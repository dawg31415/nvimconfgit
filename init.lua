-- Set leader to space
vim.g.mapleader = ' '

-- Enable line numbers
vim.opt.number = true
--vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = 'a'

-- Tab settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Lazy Configuration
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Treesitter (no LSP here)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Telescope (file search)
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

    {
        'kylechui/nvim-surround',
         version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({

            })
        end
    },

  {
    --require('plugins.mason')
    'williamboman/mason.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim'
    },
    opts = {
    
    },
    config = function(_, opts)
        require('mason').setup(opts)
        -- require('mason-lspconfig').setup({
        --     ensure_installed = { 'lua_ls', 'pylsp', 'clangd', 'ruff' },
        --     automatic_installation = true,
        -- })
        require('mason-tool-installer').setup({
            ensure_installed = { 'black', 'prettier' }
        })
    end,
  },

  -- Autocompletion (cmp)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- Other plugins (no LSP-related)
  { "folke/tokyonight.nvim" },
  { "numToStr/Comment.nvim", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
})

-- Npairs Setup 
local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
  check_ts = true, -- Enable Treesitter integration
})

-- Add Python-specific rules
npairs.add_rules({
  Rule("`", "`", "python"),       -- Backticks for f-strings
  Rule(" ", " ", "python")        -- Space-triggered pairs
    :with_pair(function(opts)
      return vim.tbl_contains({ "(", "{", "[" }, opts.char)
    end),
})

-- [[ LSP Setup ]]
-- LSP config
local cmp = require('cmp')

-- Enable completions
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
    }, {
        { name = 'buffer' },
    })
})

-- LSP keymaps
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig = require('lspconfig')

lspconfig.pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        flake8 = { enabled = false },
        pylint = { enabled = false },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        ruff = {
          enabled = true,
          extendSelect = { "I" },
          format = { "B" },
          args = { "--quiet" },
        },
        jedi_completion = { enabled = true },
        pyflakes = { enabled = false },
        mccabe = { enabled = false },
      }
    }
  },
})

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

-- lspconfig.pyright.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }

lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}



-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Colorscheme
vim.cmd[[colorscheme tokyonight]]

-- win32yank Configuration
-- vim.opt.clipboard = 'unnamedplus'
-- vim.g.clipboard = {
--     name = 'win32yank-wsl',
--     copy = {
--         ['+'] = 'win32yank -i --crlf',
--         ['*'] = 'win32yank -i --crlf',
--     }, 
--     paste = {
--         ['+'] = 'win32yank -o --lf',
--         ['*'] = 'win32yank -o --lf',
--     },
--     cache_enabled = true,
-- }
