-- basic
-- vim.keymap.set("n", "<leader>e", "<Cmd>Explore<CR>")
vim.keymap.set("n", "<C-n>", "<Cmd>nohlsearch<CR>")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "<leader>fo", ":lua vim.lsp.buf.format()<CR>", opts)

-- splits
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
vim.keymap.set("n", "<leader>#v", ":vsplit #<CR>")
vim.keymap.set("n", "<leader>s", ":split<CR>")
vim.keymap.set("n", "<leader>#s", ":split #<CR>")

-- navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- resizing
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<A-j>", ":resize +2<CR>")
vim.keymap.set("n", "<A-k>", ":resize -2<CR>")


-- fzf
local fzf = require('fzf-lua')
vim.keymap.set("n", "<leader><leader>", fzf.files)
vim.keymap.set("n", "<leader>/", fzf.live_grep)

-- neogit
vim.keymap.set("n", "<leader>gg", function()
  require("neogit").open()
end, { desc = "Open NeoGit" })

-- neo-tree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<leader>o", "<cmd>Neotree reveal<CR>", { desc = "Reveal file in Neo-tree" })

-- buffer-line
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>")

-- mini.map
local map = require("mini.map")
vim.keymap.set("n", "<leader>mm", map.toggle, { desc = "Toggle minimap" })
vim.keymap.set("n", "<leader>mf", map.toggle_focus, { desc = "Focus minimap" })

-- folding
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then vim.lsp.buf.hover() end
end)
