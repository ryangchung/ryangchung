vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.o

opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.swapfile = false
opt.signcolumn = "yes"
opt.completeopt = "menuone,noselect,popup,fuzzy"
opt.winborder = "rounded"
opt.ruler = false
vim.opt.showmode = false
opt.guifont = "Iosevka:h14"
vim.opt.cmdheight = 0
opt.laststatus = 2

_G.mode_icon = function()
	local m = vim.fn.mode()
	if m == "n" then return "󰌌" end
	if m == "i" then return "󰏫" end
	if m == "t" then return "" end
	if m == "v" then return "󰈈" end
	return "?"
end

vim.o.statusline = "%f %m%= %{%v:lua.mode_icon()%} "

local function set_statusline_highlights()
	vim.cmd("hi StatusLine guibg=NONE ctermbg=NONE")
	vim.cmd("hi StatusLineNC guibg=NONE ctermbg=NONE")
end

set_statusline_highlights()

local terminal = {
	buf = nil,
	win = nil,
}

local lazygit_terminal = {
	buf = nil,
	win = nil,
}

local centered_wins = {}

local function floating_dimensions()
	local columns = vim.o.columns
	local lines = vim.o.lines - vim.o.cmdheight

	return {
		width = math.floor(columns * 0.8),
		height = math.floor(lines * 0.8),
	}
end

local function floating_window_config()
	local dimensions = floating_dimensions()
	local columns = vim.o.columns
	local lines = vim.o.lines

	return {
		relative = "editor",
		anchor = "NW",
		width = dimensions.width,
		height = dimensions.height,
		col = math.floor((columns - dimensions.width) / 2),
		row = math.floor((lines - dimensions.height) / 2),
		style = "minimal",
		border = "rounded",
	}
end

local function open_float_term(state, command, opts)
	opts = opts or {}
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_set_current_win(state.win)
		vim.cmd.startinsert()
		return
	end

	if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
		state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[state.buf].bufhidden = opts.bufhidden or "hide"
	end

	state.win = vim.api.nvim_open_win(state.buf, true, floating_window_config())
	vim.wo[state.win].number = false
	vim.wo[state.win].relativenumber = false
	vim.wo[state.win].winhighlight = "Normal:NormalFloat,NormalNC:NormalFloat,EndOfBuffer:NormalFloat"

	if vim.bo[state.buf].buftype ~= "terminal" then
		local buf = state.buf
		if opts.terminal_escape then
			vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = buf })
		end
		vim.fn.jobstart(command, {
			term = true,
			on_exit = function()
				vim.schedule(function()
					if state.win and vim.api.nvim_win_is_valid(state.win) then
						vim.api.nvim_win_close(state.win, true)
					end
					if buf and opts.bufhidden == "wipe" and vim.api.nvim_buf_is_valid(buf) then
						vim.api.nvim_buf_delete(buf, { force = true })
					end
					state.buf = nil
					state.win = nil
				end)
			end,
		})
	end

	vim.cmd.startinsert()
end

local function toggle_terminal()
	if terminal.win and vim.api.nvim_win_is_valid(terminal.win) then
		vim.api.nvim_win_close(terminal.win, true)
		terminal.win = nil
		return
	end
	open_float_term(terminal, { vim.o.shell }, { terminal_escape = true })
end

local function lazygit()
	if vim.fn.executable("lazygit") ~= 1 then
		vim.notify("lazygit is not available in Neovim's PATH", vim.log.levels.ERROR)
		return
	end
	open_float_term(lazygit_terminal, { "lazygit" }, { bufhidden = "wipe" })
end

vim.api.nvim_create_user_command("LazyGit", lazygit, {})
vim.api.nvim_create_user_command("Lg", lazygit, {})

local function center_sidebar(command)
	vim.cmd(command)
	local win = vim.api.nvim_get_current_win()
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "wipe"
	vim.bo.swapfile = false
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.statusline = " "
	vim.wo.winfixwidth = true
	return win
end

local function toggle_centered_buffer()
	if #centered_wins > 0 then
		for _, win in ipairs(centered_wins) do
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end
		centered_wins = {}
		return
	end

	local width = math.floor((vim.o.columns - 120) / 2)
	if width < 1 then
		return
	end

	local current = vim.api.nvim_get_current_win()
	local left = center_sidebar("topleft " .. width .. "vnew")
	vim.api.nvim_set_current_win(current)
	local right = center_sidebar("botright " .. width .. "vnew")
	vim.api.nvim_set_current_win(current)
	centered_wins = { left, right }
end

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

local function gh_pr(args)
	if vim.fn.executable("gh") ~= 1 then
		vim.notify("gh is not available in Neovim's PATH", vim.log.levels.ERROR)
		return
	end

	vim.system(vim.list_extend({ "gh", "pr" }, args), { text = true }, function(result)
		if result.code == 0 then
			return
		end

		local stderr = result.stderr or ""
		local stdout = result.stdout or ""
		local message = vim.trim(stderr ~= "" and stderr or stdout)
		if message == "" then
			message = "gh pr " .. table.concat(args, " ") .. " exited with code " .. result.code
		end

		vim.schedule(function()
			vim.notify(message, vim.log.levels.ERROR)
		end)
	end)
end

map("n", "<leader>o", "<cmd>update<CR><cmd>source $MYVIMRC<CR>", "Reload config")
map("n", "<leader>w", "<cmd>write<CR>", "Write buffer")
map("n", "<leader>q", "<cmd>quit<CR>", "Quit window")
map("n", "<leader>z", "zz", "Center cursor line")
map("n", "<leader>p", toggle_centered_buffer, "Toggle centered buffer")
map({ "n", "o", "x" }, "ss", function()
	local ok, flash = pcall(require, "flash")
	if ok then
		flash.jump()
	end
end, "Flash jump")
map("n", "ff", function()
	MiniPick.builtin.files()
end, "Find files")
map("n", "fg", function()
	MiniPick.builtin.grep_live()
end, "Live grep")
map("n", "<leader>t", toggle_terminal, "Toggle terminal")
map("n", "lg", lazygit, "Open lazygit")
map("n", "<leader>lf", vim.lsp.buf.format, "Format buffer")
map("n", "K", vim.lsp.buf.hover, "Hover")
map("n", "gd", vim.lsp.buf.definition, "Go to definition")
map("n", "gr", vim.lsp.buf.references, "List references")
map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
map({ "n", "v" }, "<leader>y", [["+y]], "Yank to system clipboard")

map("n", "<leader>gh", function()
	gh_pr({ "list", "--web" })
end, "Open pull requests")
map("n", "<leader>gp", function()
	gh_pr({ "view", "--web" })
end, "Open current branch pull request")

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/Saghen/blink.cmp",             version = "v1.9.1" },
})

require("catppuccin").setup({
	flavour = "mocha",
	integrations = {
		blink_cmp = true,
		mini = {
			enabled = true,
		},
	},
})

vim.cmd.colorscheme("catppuccin-mocha")
set_statusline_highlights()

local has_flash, flash = pcall(require, "flash")
if has_flash then
	flash.setup({
		modes = {
			char = {
				enabled = false,
			},
			search = {
				enabled = true,
			},
		},
	})
end

require("mini.pick").setup({
	window = {
		config = floating_window_config,
	},
})
require("mini.pairs").setup()

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<Tab>"] = { "select_and_accept", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = false },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})

vim.diagnostic.config({
	virtual_text = true,
})

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = false,
				useGitIgnore = true,
				ignoreDir = { ".devenv", ".devenv*", ".direnv" },
				library = { vim.env.VIMRUNTIME },
			},
		})
	end,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = { "vim" },
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "basic",
				useLibraryCodeForTypes = true,
			},
		},
	},
})

vim.lsp.enable({ "lua_ls", "basedpyright" })
