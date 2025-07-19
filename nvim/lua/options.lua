-- Appearance
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 6
vim.o.statuscolumn = [[%!printf('%3d %3d', v:lnum, v:relnum)]]

-- Scrolling and layout
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"

-- Indentation and tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Files and backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50

-- Text rendering
vim.opt.encoding = "utf-8"
vim.opt.list = true
vim.opt.listchars = {
	tab = "> ",
	extends = "»",
	precedes = "«",
	nbsp = "·",
	trail = "·",
}

-- LSP diagnostics
vim.diagnostic.config({
	virtual_text = true,
})

-- Format on write
local Stylua = vim.api.nvim_create_augroup("Stylua", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = Stylua,
	pattern = "*.lua",
	command = "silent !stylua %",
})

local NixFmt = vim.api.nvim_create_augroup("NixFmt", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = NixFmt,
	pattern = "*.nix",
	command = "silent !nixpkgs-fmt %",
})
