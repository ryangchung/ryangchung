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

_G.mode_icon = function()
	local m = vim.fn.mode()
	if m == "n" then return "󰌌" end
	if m == "i" then return "󰏫" end
	if m == "t" then return "" end
	if m == "v" then return "󰈈" end
	return "?"
end

vim.o.statusline = "%f  %{%v:lua.mode_icon()%}"

local function set_statusline_highlights()
	vim.cmd("hi StatusLine guibg=NONE ctermbg=NONE")
	vim.cmd("hi StatusLineNC guibg=NONE ctermbg=NONE")
end

set_statusline_highlights()

local telescope_ui_group = vim.api.nvim_create_augroup("TelescopeUi", { clear = true })
local hidden_statusline_depth = 0
local saved_laststatus = vim.o.laststatus

local function hide_statusline()
	if hidden_statusline_depth == 0 then
		saved_laststatus = vim.o.laststatus
		vim.o.laststatus = 0
	end
	hidden_statusline_depth = hidden_statusline_depth + 1
end

local function show_statusline()
	if hidden_statusline_depth == 0 then
		return
	end
	hidden_statusline_depth = hidden_statusline_depth - 1
	if hidden_statusline_depth == 0 then
		vim.o.laststatus = saved_laststatus
	end
end

vim.api.nvim_create_autocmd("CmdlineEnter", {
	group = telescope_ui_group,
	callback = hide_statusline,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = telescope_ui_group,
	callback = function()
		vim.schedule(show_statusline)
	end,
})

local terminal = {
	buf = nil,
	win = nil,
}

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
		width = dimensions.width,
		height = dimensions.height,
		col = math.floor((columns - dimensions.width) / 2),
		row = math.floor((lines - dimensions.height) / 2 - 1),
		style = "minimal",
		border = "rounded",
	}
end

local function telescope_picker_opts()
	local dimensions = floating_dimensions()

	return {
		layout_strategy = "horizontal",

		layout_config = {
			width = dimensions.width,
			height = dimensions.height,
			prompt_position = "top",
			preview_cutoff = 0,
			horizontal = {
				preview_width = math.floor(dimensions.width * 0.55),
			},
		},
		sorting_strategy = "ascending",
	}
end

local function toggle_terminal()
	if terminal.win and vim.api.nvim_win_is_valid(terminal.win) then
		vim.api.nvim_win_close(terminal.win, true)
		terminal.win = nil
		return
	end

	if not (terminal.buf and vim.api.nvim_buf_is_valid(terminal.buf)) then
		terminal.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[terminal.buf].bufhidden = "hide"
	end

	terminal.win = vim.api.nvim_open_win(terminal.buf, true, floating_window_config())

	vim.wo[terminal.win].number = false
	vim.wo[terminal.win].relativenumber = false
	vim.wo[terminal.win].winhighlight =
	"Normal:TelescopeNormal,NormalNC:TelescopeNormal,FloatBorder:TelescopeBorder,EndOfBuffer:TelescopeNormal"

	if vim.bo[terminal.buf].buftype ~= "terminal" then
		local buf = terminal.buf


		vim.fn.jobstart({ vim.o.shell }, {
			term = true,
			on_exit = function()
				vim.schedule(function()
					if terminal.win and vim.api.nvim_win_is_valid(terminal.win) then
						vim.api.nvim_win_close(terminal.win, true)
					end
					if buf and vim.api.nvim_buf_is_valid(buf) then
						vim.api.nvim_buf_delete(buf, { force = true })
					end
					terminal.buf = nil
					terminal.win = nil
				end)
			end,
		})
	end

	vim.cmd.startinsert()
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
map("n", "<leader>p", "<cmd>NoNeckPain<CR>", "Toggle centered buffer")
map({ "n", "o", "x" }, "ss", function()
	local ok, flash = pcall(require, "flash")
	if ok then
		flash.jump()
	end
end, "Flash jump")
map("n", "ff", function()
	require("telescope.builtin").find_files(telescope_picker_opts())
end, "Find files")
map("n", "fg", function()
	require("telescope.builtin").live_grep(telescope_picker_opts())
end, "Live grep")
map("n", "<leader>t", toggle_terminal, "Toggle terminal")
map("n", "<leader>lf", vim.lsp.buf.format, "Format buffer")
map("n", "K", vim.lsp.buf.hover, "Hover")
map("n", "gd", vim.lsp.buf.definition, "Go to definition")
map("n", "gr", vim.lsp.buf.references, "List references")
map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
map({ "n", "v" }, "<leader>y", [["+y]], "Yank to system clipboard")
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]])
map("n", "<leader>gh", function()
	gh_pr({ "list", "--web" })
end, "Open pull requests")
map("n", "<leader>gp", function()
	gh_pr({ "view", "--web" })
end, "Open current branch pull request")

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/shortcuts/no-neck-pain.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp",             version = "v1.9.1" },
})

require("catppuccin").setup({
	flavour = "mocha",
	integrations = {
		blink_cmp = true,
		mini = {
			enabled = true,
		},
		telescope = {
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

local has_no_neck_pain, no_neck_pain = pcall(require, "no-neck-pain")
if has_no_neck_pain then
	no_neck_pain.setup({
		width = 120,
		buffers = {
			wo = {
				statusline = " ",
			},
		},
	})
end

local actions = require('telescope.actions')

require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		mappings = {
			i = {
				['esc'] = actions.close,
			},
		},
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
