-- basic
vim.keymap.set("n", "<leader>e", "<Cmd>Explore<CR>")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "<leader>fo", ":lua vim.lsp.buf.format()<CR>", opts)

-- fzf
local fzf = require('fzf-lua')
vim.keymap.set("n", "<leader><leader>", fzf.files)
vim.keymap.set("n", "<leader>/", fzf.live_grep)
