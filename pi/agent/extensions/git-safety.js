const GIT_GLOBAL_OPTIONS_WITH_VALUE = new Set([
	"-C",
	"-c",
	"--config-env",
	"--exec-path",
	"--git-dir",
	"--namespace",
	"--super-prefix",
	"--work-tree",
]);

function shellTokens(segment) {
	return (segment.match(/(?:[^\s"'\\]+|"(?:\\.|[^"])*"|'[^']*')+/g) ?? []).map(
		(token) => {
			if (
				(token.startsWith('"') && token.endsWith('"')) ||
				(token.startsWith("'") && token.endsWith("'"))
			) {
				return token.slice(1, -1);
			}
			return token;
		},
	);
}

function gitArguments(segment) {
	const tokens = shellTokens(segment);
	const gitIndex = tokens.findIndex((token) => /(?:^|\/)git$/.test(token));
	if (gitIndex < 0) return undefined;

	for (let index = gitIndex + 1; index < tokens.length; index += 1) {
		const token = tokens[index];
		if (GIT_GLOBAL_OPTIONS_WITH_VALUE.has(token)) {
			index += 1;
			continue;
		}
		if (
			[...GIT_GLOBAL_OPTIONS_WITH_VALUE].some((option) =>
				token.startsWith(`${option}=`),
			)
		) {
			continue;
		}
		if (token.startsWith("-")) continue;
		return tokens.slice(index);
	}
	return undefined;
}

function hasShortFlag(args, flag) {
	return args.some(
		(argument) =>
			argument === `-${flag}` ||
			(/^-[A-Za-z]+$/.test(argument) && argument.slice(1).includes(flag)),
	);
}

const GIT_RISK_RULES = [
	{
		subcommand: "reset",
		reason: "reset can discard worktree changes",
		matches: (args) =>
			["--hard", "--merge", "--keep"].some((option) => args.includes(option)),
	},
	{
		subcommand: "clean",
		reason: "clean can permanently delete untracked files",
		matches: (args) => !args.includes("--dry-run") && !hasShortFlag(args, "n"),
	},
	{
		subcommand: "restore",
		reason: "restore can overwrite worktree or index changes",
		matches: () => true,
	},
	{
		subcommand: "checkout",
		reason: "checkout can overwrite worktree changes",
		matches: (args) =>
			args.includes("--force") ||
			hasShortFlag(args, "f") ||
			args.includes("--") ||
			args.includes(".") ||
			args.includes(":/"),
	},
	{
		subcommand: "switch",
		reason: "forced switch can discard worktree changes",
		matches: (args) =>
			args.includes("--discard-changes") ||
			args.includes("--force") ||
			hasShortFlag(args, "f"),
	},
	{
		subcommand: "branch",
		reason: "forced branch deletion can remove unmerged history",
		matches: (args) =>
			args.includes("-D") ||
			(args.includes("--delete") &&
				(args.includes("--force") || hasShortFlag(args, "f"))),
	},
	{
		subcommand: "stash",
		reason: "stash deletion can remove recovery data",
		matches: (args) => ["drop", "clear"].includes(args[0] ?? ""),
	},
	{
		subcommand: "push",
		reason: "force push can rewrite shared remote history",
		matches: (args) =>
			args.includes("--force") ||
			args.includes("--force-with-lease") ||
			args.includes("--force-if-includes") ||
			hasShortFlag(args, "f"),
	},
	{
		subcommand: "reflog",
		reason: "reflog expiration can remove recovery history",
		matches: (args) => args[0] === "expire",
	},
	{
		subcommand: "gc",
		reason: "aggressive pruning can permanently remove Git objects",
		matches: (args) =>
			args.some((argument) => ["--prune=now", "--prune=all"].includes(argument)),
	},
	{
		subcommand: "worktree",
		reason: "forced worktree removal can discard changes",
		matches: (args) =>
			args[0] === "remove" &&
			(args.includes("--force") || hasShortFlag(args, "f")),
	},
];

function classifyGitCommand(command) {
	for (const rawSegment of command.split(/&&|\|\||[;\n]/)) {
		const segment = rawSegment.trim();
		const args = gitArguments(segment);
		if (!args?.length) continue;

		const [subcommand, ...rest] = args;
		const risk = GIT_RISK_RULES.find(
			(rule) => rule.subcommand === subcommand && rule.matches(rest),
		);
		if (risk) return { reason: risk.reason, segment };
	}
	return undefined;
}

async function guardDirtyRepo(pi, ctx, action) {
	const result = await pi.exec(
		"git",
		["-C", ctx.cwd, "status", "--porcelain=v1", "--untracked-files=normal"],
		{ signal: ctx.signal },
	);
	if (result.code !== 0) return undefined;

	const changes = result.stdout
		.split("\n")
		.filter((line) => line.trim().length > 0);
	if (changes.length === 0) return undefined;

	if (!ctx.hasUI) return { cancel: true };

	const proceed = await ctx.ui.confirm(
		"Uncommitted changes",
		`${changes.length} changed file(s) detected. ${action} anyway?`,
	);
	if (!proceed) {
		ctx.ui.notify(
			"Session action cancelled; checkpoint or commit your changes first.",
			"warning",
		);
		return { cancel: true };
	}
	return undefined;
}

export default function gitSafety(pi) {
	pi.on("tool_call", async (event, ctx) => {
		if (event.toolName !== "bash") return undefined;

		const risk = classifyGitCommand(event.input.command);
		if (!risk) return undefined;

		if (!ctx.hasUI) {
			return {
				block: true,
				reason: `Blocked destructive Git command in noninteractive mode: ${risk.reason}`,
			};
		}

		const approved = await ctx.ui.confirm(
			"Potentially destructive Git command",
			`${risk.segment}\n\nRisk: ${risk.reason}\n\nAllow this command?`,
		);
		if (!approved) {
			return { block: true, reason: `User declined: ${risk.reason}` };
		}
		return undefined;
	});

	pi.on("session_before_switch", (event, ctx) => {
		const action =
			event.reason === "new" ? "Start a new session" : "Switch sessions";
		return guardDirtyRepo(pi, ctx, action);
	});

	pi.on("session_before_fork", (event, ctx) => {
		const action =
			event.position === "at" ? "Clone this session" : "Fork this session";
		return guardDirtyRepo(pi, ctx, action);
	});

	pi.registerCommand("git-safety", {
		description: "Show Git safety guard status",
		handler: async (_args, ctx) => {
			const result = await pi.exec("git", [
				"-C",
				ctx.cwd,
				"status",
				"--porcelain=v1",
				"--untracked-files=normal",
			]);
			let state = "active; current directory is not a Git repository";
			if (result.code === 0) {
				state = result.stdout.trim()
					? "active; repository has uncommitted changes"
					: "active; repository is clean";
			}
			ctx.ui.notify(`Git safety guard: ${state}`, "info");
		},
	});
}
