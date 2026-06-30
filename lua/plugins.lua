-- neogit
vim.pack.add({
	{src = "https://github.com/NeogitOrg/neogit"},
	{src = "https://github.com/nvim-lua/plenary.nvim"},
	{src = "https://github.com/sindrets/diffview.nvim"},
})
require("neogit").setup({
  integrations = {
	diffview = true,
  },
  kind = "tab",
})

-- neo tree
vim.pack.add({
	{src = "https://github.com/nvim-neo-tree/neo-tree.nvim"},
	{src = "https://github.com/nvim-lua/plenary.nvim"},
	{src = "https://github.com/nvim-tree/nvim-web-devicons"},
	{src = "https://github.com/MunifTanjim/nui.nvim"},
})
require("neo-tree").setup({
	event_handlers = {
		{
			event = "file_opened",
			handler = function()
				vim.schedule(function()
				  vim.cmd("Neotree focus")
				end)
			end,
		},
	},
})

-- buffer line
vim.pack.add({
	{src = "https://github.com/akinsho/bufferline.nvim"},
	{src = "https://github.com/nvim-tree/nvim-web-devicons"},
})
require("bufferline").setup({})

-- mini.map
vim.pack.add({
	{src = "https://github.com/nvim-mini/mini.nvim"},
	{src = "https://github.com/lewis6991/gitsigns.nvim"},
})
require("mini.map").setup({
  integrations = {
    require("mini.map").gen_integration.builtin_search(),
    require("mini.map").gen_integration.diagnostic({
      error = "DiagnosticFloatingError",
      warn  = "DiagnosticFloatingWarn",
      info  = "DiagnosticFloatingInfo",
      hint  = "DiagnosticFloatingHint",
    }),
    require("mini.map").gen_integration.gitsigns(),
  },

  symbols = {
    encode = require("mini.map").gen_encode_symbols.dot("4x2"),
    scroll_line = "█",
    scroll_view = "┃",
  },

  window = {
    side = "right",
    width = 15,
    winblend = 20,
    show_integration_count = false,
    focusable = false,
    zindex = 10,
  },
})

-- folding
vim.pack.add({
	{src = "https://github.com/kevinhwang91/nvim-ufo"},
	{src = "https://github.com/kevinhwang91/promise-async"},
})
require("ufo").setup({})

-- colorscheme
vim.pack.add({
	{src = "https://github.com/folke/tokyonight.nvim"},
})

require("tokyonight").setup({})

-- auto pairs
vim.pack.add({
	{src = "https://github.com/windwp/nvim-autopairs"},
})

require("nvim-autopairs").setup({
    check_ts = true,
    map_cr = true,
})

-- combine with cmp
vim.pack.add({
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
})

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done()
)

-- mason
vim.pack.add({
	{src = "https://github.com/mason-org/mason.nvim"},
})

require("mason").setup({})

-- lualine 
vim.pack.add({
	{src = "https://github.com/nvim-lualine/lualine.nvim"},
})

require("lualine").setup({
	options = {
		globalStatus = true,
	},
})

-- fzf (search)
vim.pack.add({
	{src = "https://github.com/ibhagwan/fzf-lua"},
})

local actions = require('fzf-lua.actions')
require('fzf-lua').setup({
    winopts = { backdrop = 85 },
    keymap = {
        builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<C-p>"] = "toggle-preview",
        },
        fzf = {
            ["ctrl-a"] = "toggle-all",
            ["ctrl-t"] = "first",
            ["ctrl-g"] = "last",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
        }
    },
    actions = {
        files = {
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-n"] = actions.toggle_ignore,
            ["ctrl-h"] = actions.toggle_hidden,
            ["enter"]  = actions.file_edit_or_qf,
        }
    }
})

-- novice (command line
vim.pack.add({
  {
    src = "https://github.com/folke/noice.nvim",
  },
  {
    src = "https://github.com/MunifTanjim/nui.nvim",
  },
  {
    src = "https://github.com/rcarriga/nvim-notify",
  },
})

require("noice").setup({
	cmdline = {
		view = "cmdline_popup", -- floating cmdline
	},
	messages = {
		view = "mini",
	},
	popupmenu = {
		backend = "cmp",
	},
	views = {
		cmdline_popup = {
			position = {
				row = 1,
				col = "50%",
			}
		}
	},
})

-- blink (kmap)
vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require('blink.cmp').setup({
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
    keymap = {
        preset = "default",
        ["<C-space>"] = {},
        ["<C-p>"] = {},
        -- ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Tab>"] = { "select_and_accept" },
        -- ["<CR>"] = { "select_and_accept" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_down", "fallback" },
        ["<C-f>"] = { "scroll_documentation_up", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        -- ["<C-e>"] = { "hide" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        }
    },

    cmdline = {
        keymap = {
            preset = 'inherit',
            -- ['<CR>'] = { 'accept_and_enter', 'fallback' },
        },
    },

    sources = { default = { "lsp" } }
})

-- roblox
vim.pack.add({
    { src = "https://github.com/lopi-py/luau-lsp.nvim", name = "luau-lsp" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

local function rojo_project()
  return vim.fs.root(0, function(name)
    return name:match ".+%.project%.json$"
  end)
end

require("luau-lsp").setup({
	platform = {
		type = rojo_project() and "roblox" or "standard",
	},
	types = {
		roblox_security_level = "PluginSecurity",
	},
	sourcemap = {
		enabled = true,
		autogenerate = true, -- automatic generation when the server is initialized
		sourcemap_file = "sourcemap.json",
	},
	fflags = {
		enable_new_solver = true,
		sync = true,
	},
})

if rojo_project() then
  vim.filetype.add {
    extension = {
      lua = function(path)
        return path:match "%.nvim%.lua$" and "lua" or "luau"
      end,
    },
  }
end
