--[[
    vibecoded as fuck
]]

-- [[ basic ]] --

-- basic settings
vim.opt.mouse = "a"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- visuals
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.cursorline = true


-- [[ lazy ]] --

-- lazy installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then -- install lazy
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- lazy configuration
local lazy = require("lazy")
lazy.setup({
    -- file explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("nvim-tree").setup({
                view = { width=30 },
                actions = { 
                    open_file = { quit_on_open = true },
                }
            })
        end,
    },

    -- buffer management
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    number = "ordinal",
                    offsets = { { filetype = "NvimTree", text = "file explorer" } },
                    indicator = {
                        icon = "*", -- gotta be near font icon
                        style = 'icon',
                    },
                    buffer_close_icon = 'x',
                    modified_icon = '0',
                    close_icon = '#',
                    left_trunc_marker = 'l',
                    right_trunc_marker = 'r',
                },
            })
        end,
    },

    -- mason setup
    {
        "williamboman/mason.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        opts = {
        },
        config = function(_, opts)
            require("mason").setup(opts)
            -- require("mason-lspconfig").setup({
            --     ensure_installer = { 'lua_ls', 'pyright', 'clangd', 'ruff' },
            --     automatic_installation = true,
            -- }) --WORKS ?
            require("mason-tool-installer").setup({
                ensure_installer = { 'black', 'prettier', 'lua_ls', 
                    'pyright', 'clangd', 'ruff' },
            })
        end,
    },

    -- cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
    },

    -- theme
    { "folke/tokyonight.nvim" }
})


-- [ LSP configuration ] --

-- setup capabilities (completions for dumbasses)
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config(
    '*', {
        capabilities = capabilities,
    },
    'lua_ls', {
        settings = {
            Lua = {
                diagnostics = { globals = { 'vim' } }
            }
        }
    },
    'pyright', {
    },
    'ruff', {
    },
    'clangd', {
    }
)
vim.lsp.enable({ 'lua_ls', 'pyright', 'ruff', 'clangd', })


-- [ additional ] --

-- win32 yank
vim.opt.clipboard = 'unnamedplus'
vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
        ['+'] = 'win32yank -i --crlf',
        ['*'] = 'win32yank -i --crlf',
    },
    paste = {
        ['+'] = 'win32yank -o --lf',
        ['*'] = 'win32yank -o --lf',
    },
    cache_enabled = true,
}

vim.cmd[[colorscheme tokyonight]]
