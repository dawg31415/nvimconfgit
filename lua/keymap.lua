-- basic
-- vim.keymap.set("n", "<leader>e", "<Cmd>Explore<CR>")
vim.keymap.set("n", "<C-n>", "<Cmd>nohlsearch<CR>")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "<leader>fo", ":lua vim.lsp.buf.format()<CR>", opts)

-- splits
vim.keymap.set("n", "<leader>v", ":vsplit #<CR>", { desc = "vsplit tab & go prev" })
vim.keymap.set("n", "<leader><C-v>", ":vsplit<CR>", { desc = "vsplit" })
vim.keymap.set("n", "<leader>s", ":split #<CR>", { desc = "split & go prev" })
vim.keymap.set("n", "<leader><C-s>", ":split<CR>", { desc = "split" })

-- windows navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to <<< LEFT window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to window BELOW" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to UPPER window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to >>> RIGHT window" })

-- windows resizing
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>", { desc = "RESIZE window <<< LEFT" })
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>", { desc = "RESIZE window >>> RIGHT" })
vim.keymap.set("n", "<A-j>", ":resize +2<CR>", { desc = "RESIZE window DOWN" })
vim.keymap.set("n", "<A-k>", ":resize -2<CR>", { desc = "RESIZE window UP" })


-- fzf
local fzf = require('fzf-lua')
vim.keymap.set("n", "<leader><leader>", fzf.files, { desc = "Open fzf files search" })
vim.keymap.set("n", "<leader>/", fzf.live_grep, { desc = "Open fzf text search" })

-- sessions
-- vim.keymap.set("n", "<leader>qs", function()
--   require("persistence").load()
-- end)
--
-- vim.keymap.set("n", "<leader>ql", function()
--   require("persistence").load({ last = true })
-- end)
vim.keymap.set("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session" })
vim.keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session" })
vim.keymap.set("n", "<leader>wl", "<cmd>AutoSession search<CR>", { desc = "List sessions" })
vim.keymap.set("n", "<leader>wd", "<cmd>AutoSession delete<CR>", { desc = "Delete session" })

-- neogit
vim.keymap.set("n", "<leader>gg", function()
  require("neogit").open()
end, { desc = "Open NeoGit" })

-- neo-tree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<leader>o", "<cmd>Neotree reveal<CR>", { desc = "Reveal file in Neo-tree" })

-- buffer-line
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "GO to PREV buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "GO to NEXT buffer" })
vim.keymap.set("n", "<A-h>", "<cmd>BufferLineMovePrev<CR>", { desc = "MOVE buffer to LEFT" })
vim.keymap.set("n", "<A-l>", "<cmd>BufferLineMoveNext<CR>", { desc = "MOVE buffer to RIGHT" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- mini.map
local map = require("mini.map")
vim.keymap.set("n", "<leader>mm", map.toggle, { desc = "Toggle minimap" })
vim.keymap.set("n", "<leader>mf", map.toggle_focus, { desc = "Focus minimap" })

-- folding
vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open folds" })
vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close folds" })
vim.keymap.set("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then vim.lsp.buf.hover() end
end, { desc = "Peak fold" })
