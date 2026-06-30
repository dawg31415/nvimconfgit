-- vim.opt.guicursor = "i:block"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.colorcolumn = "80"
vim.opt.listchars = "tab:> ,multispace:|    ,eol:<"
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

-- folding
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- scheme
vim.cmd.colorscheme "tokyonight"
