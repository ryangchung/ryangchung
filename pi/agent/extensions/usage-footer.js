import { homedir } from "node:os";
import { isAbsolute, relative, resolve, sep } from "node:path";

// pi-usage publishes this documented status key independently of package version.
const USAGE_STATUS_KEY = "usage";
const ANSI_ESCAPE = /\x1b(?:\[[0-?]*[ -/]*[@-~]|\][^\x07]*(?:\x07|\x1b\\))/gu;

function stripAnsi(text) {
  return text.replace(ANSI_ESCAPE, "");
}

function visibleWidth(text) {
  return [...stripAnsi(text)].length;
}

function truncate(text, width, ellipsis = "...") {
  const plain = stripAnsi(text);
  if (visibleWidth(plain) <= width) return plain;
  if (width <= 0) return "";
  if (width <= ellipsis.length) return ellipsis.slice(0, width);
  return `${[...plain].slice(0, width - ellipsis.length).join("")}${ellipsis}`;
}

function align(left, right, width) {
  if (!right) return truncate(left, width);

  const availableForLeft = width - visibleWidth(right) - 2;
  if (availableForLeft < 1) return truncate(right, width);

  const fittedLeft = truncate(left, availableForLeft);
  const padding = " ".repeat(
    Math.max(2, width - visibleWidth(fittedLeft) - visibleWidth(right)),
  );
  return truncate(`${fittedLeft}${padding}${right}`, width);
}

function formatTokens(count) {
  if (count < 1_000) return count.toString();
  if (count < 10_000) return `${(count / 1_000).toFixed(1)}k`;
  if (count < 1_000_000) return `${Math.round(count / 1_000)}k`;
  if (count < 10_000_000) return `${(count / 1_000_000).toFixed(1)}M`;
  return `${Math.round(count / 1_000_000)}M`;
}

function formatDirectory(cwd) {
  const home = homedir();
  const resolvedCwd = resolve(cwd);
  const resolvedHome = resolve(home);
  const relativeToHome = relative(resolvedHome, resolvedCwd);
  const isInsideHome =
    relativeToHome === "" ||
    (relativeToHome !== ".." &&
      !relativeToHome.startsWith(`..${sep}`) &&
      !isAbsolute(relativeToHome));

  if (!isInsideHome) return cwd;
  return relativeToHome === "" ? "~" : `~${sep}${relativeToHome}`;
}

function sanitizeStatus(text) {
  return stripAnsi(text)
    .replace(/[\r\n\t]/g, " ")
    .replace(/ +/g, " ")
    .trim();
}

function collectTokenUsage(ctx) {
  const totals = { input: 0, output: 0 };

  for (const entry of ctx.sessionManager.getEntries()) {
    let usage;
    if (entry.type === "message" && entry.message.role === "assistant") {
      usage = entry.message.usage;
    } else if (
      entry.type === "message" &&
      entry.message.role === "toolResult" &&
      entry.message.usage
    ) {
      usage = entry.message.usage;
    } else if (
      (entry.type === "branch_summary" || entry.type === "compaction") &&
      entry.usage
    ) {
      usage = entry.usage;
    }

    if (!usage) continue;
    totals.input += usage.input;
    totals.output += usage.output;
  }

  return totals;
}

function leftSide(ctx) {
  const directory = formatDirectory(ctx.sessionManager.getCwd());
  const name = ctx.model?.id ?? "no-model";
  const effort = ctx.thinkingLevel ?? "off";
  return `${directory} | ${name} • ${effort}`;
}

function rightSide(ctx, codexUsage) {
  const tokens = collectTokenUsage(ctx);
  const tokenUsage = `↑${formatTokens(tokens.input)} ↓${formatTokens(tokens.output)}`;
  return codexUsage ? `${tokenUsage} | ${codexUsage}` : tokenUsage;
}

function renderFooter(ctx, theme, footerData, width) {
  const usageStatus = footerData.getExtensionStatuses().get(USAGE_STATUS_KEY);
  const codexUsage = usageStatus ? sanitizeStatus(usageStatus) : "";
  return [
    theme.fg("dim", align(leftSide(ctx), rightSide(ctx, codexUsage), width)),
  ];
}

function createFooter(ctx, tui, theme, footerData) {
  const unsubscribe = footerData.onBranchChange(() => tui.requestRender());
  return {
    dispose: unsubscribe,
    invalidate() {},
    render: (width) => renderFooter(ctx, theme, footerData, width),
  };
}

export default function usageFooter(pi) {
  pi.on("session_start", (_event, ctx) => {
    ctx.ui.setFooter((tui, theme, footerData) =>
      createFooter(ctx, tui, theme, footerData),
    );
  });
}
