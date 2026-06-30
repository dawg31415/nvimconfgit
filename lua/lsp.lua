-- vim.lsp.config("luau-lsp", {
-- 	cmd = { "luau-lsp", "lsp", "--definitions:@roblox=/home/dawggg/.local/share/nvim/luau-lsp/defs/globalTypes.PluginSecurity.d.luau", "--docs=/home/dawggg/.local/share/nvim/luau-lsp/docs/api-docs.json", "--no-flags-enabled" }
-- 	filetypes = { 'lua', 'luau' },
-- 	root_markers = { '.git', 'default.project.json' }
-- })

vim.lsp.enable({
	"rust-analyzer",
	-- "lua_ls",
	"pyright",
	-- "luau-lsp",
})

vim.diagnostic.config({ virtual_text = true })
