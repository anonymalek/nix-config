vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set termguicolors")

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

plugins = {
  { "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        -- background = "hard",
        ui_contrast = "high",
        colours_override = function(pal)
          --pal.bg1 = "#191f24"
          pal.bg0 = "#121313"
          pal.red = "#ff073a"
          pal.orange = "#FF5F1F"
          pal.yellow = "#FFF01F"
          pal.green = "#86B95A"
          pal.aqua = "#21f8f6"
          pal.blue = "#1f51ff"
          pal.purple = "#bc13fe"
        end
      })
    end },

  { "freddiehaddad/feline.nvim",
    opts = {},
    config = function(_, opts)
      require('feline').setup({})
    end },

  { "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
      require("nvim-tree").setup()
    end },

  { "nvim-tree/nvim-web-devicons" },

  { "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end },

  { "folke/neodev.nvim",
    opts = {},
    config = function()
      require("neodev").setup({})
    end },

  { "williamboman/mason.nvim",
    opts = { ensure_installed = { "clangd",
                                  "clang-format",
                                  "lua-language-server",
                                  "codelldb",
                                  "php-cs-fixer",
                                  "phpcbf",
                                  "phpstan" } } },

  { "williamboman/mason-lspconfig.nvim" },

  { "sbdchd/neoformat" },

  { "neovim/nvim-lspconfig",
    config = function()
      require 'configs.lspconfig'
    end},

  --{ "hrsh7th/cmp-nvim-lsp",
    --config = function()
    --  require'cmp'.setup {
    --    sources = {
    --      { name = 'nvim_lsp' }
    --    }
    --  }
    --end },

  --{ "hrsh7th/cmp-buffer" },

  --{ "hrsh7th/cmp-path" },

  --{ "hrsh7th/cmp-cmdline" },

  --{ "hrsh7th/nvim-cmp" },
  { "ms-jpq/coq_nvim",
    branch = "coq",
    lazy = false },

  { "ms-jpq/coq.artifacts",
    branch = "artifacts",
    lazy = false },

  { "ms-jpq/coq.thirdparty",
    branch = "3p",
    lazy = false },

  { "scrooloose/nerdcommenter" },

  { "nvim-lua/plenary.nvim" },

  { "lewis6991/gitsigns.nvim",
    config = function()
      require "configs.gitsigns"
    end },

  { "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end },

  { "folke/lsp-trouble.nvim",
    opts = { noremap = true,
             silent = true },
    config = function()
      require "configs.lsp-trouble"
    end },

  { "tami5/lspsaga.nvim",
    opts = { noremap = true,
             silent = true },
    config = function()
      opts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap('n', 'ga', '<Cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts) -- eg. autoimport
      vim.api.nvim_set_keymap('v', 'ga', ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>', opts) -- eg. autoimport
      vim.api.nvim_set_keymap('n', 'h', '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gr', '<Cmd>lua require("lspsaga.rename").rename()<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gn', '<Cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gN', '<Cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>', opts)
    end },

  { 'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' } },

  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    version = nil },

  { "mfussenegger/nvim-dap",
    config = function()
      require "configs.dap"
    end },

  { "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim",
                     "mfussenegger/nvim-dap" },
    opts = { handlers = {} } },

  { "onsails/lspkind.nvim" },

  { "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      { "williamboman/mason.nvim",
        opts = { registries = { "github:nvim-java/mason-registry",
                                "github:mason-org/mason-registry" } } } } },

  { "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end }
}

opts = {}

require("lazy").setup(plugins, opts)

vim.cmd("set rnu")
vim.cmd("set t_Co=256")
--vim.cmd.colorscheme "pride"
--vim.cmd.colorscheme "everforest"

require("everforest").load()

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, {})

local tree_api = require("nvim-tree.api")
vim.keymap.set('n', '<Space>e', tree_api.tree.toggle)

local treesitter_config = require('nvim-treesitter.configs')
treesitter_config.setup({
  -- ensure_installed = { "lua", "javascript", "typescript", "c", "c_sharp", "cpp", "css", "cmake", "diff", "vim", "latex", "make", "ninja", "php", "python", "ruby", "rust", "yaml" },
  highlight = { enabled = true },
  indent = { enabled = true }
})

-- Copy to clipboard
vim.keymap.set('v', '<Space>y', '"+y')
vim.keymap.set('n', '<Space>Y', '"+yg_')
vim.keymap.set('n', '<Space>y', '"+y')
vim.keymap.set('n', '<Space>yy', '"+yy')

-- Paste from clipboard
vim.keymap.set('n', '<Space>p', '"+p')
vim.keymap.set('n', '<Space>P', '"+P')
vim.keymap.set('v', '<Space>p', '"+p')
vim.keymap.set('v', '<Space>P', '"+P')

-- Debugger
vim.keymap.set('n', '<Space>db', '<cmd> DapToggleBreakpoint <CR>')
vim.keymap.set('n', '<Space>dr', '<cmd> DapContinue <CR>')
vim.fn.sign_define('DapBreakpoint', { text='',
                                      texthl='red',
                                      linehl='',
                                      numhl='' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ',
                                      texthl='yellow',
                                      linehl='',
                                      numhl='' })
vim.fn.sign_define('DapBreakpointRejected', { text='',
                                      texthl='orange',
                                      linehl='',
                                      numhl='' })
vim.fn.sign_define('DapLogPoint', { text='',
                                      texthl='blue',
                                      linehl='',
                                      numhl='' })
vim.fn.sign_define('DapStopped', { text='',
                                      texthl='green',
                                      linehl='',
                                      numhl='' })

-- Neovide
if vim.g.neovide then
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_trail_size = 0.4
  vim.g.neovide_scroll_animation_length = 0.18
  vim.g.neovide_refresh_rate = 60
  vim.o.guifont = "Comic Mono:h10"
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function (ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Space>lw', vim.lsp.buf.signature_help, opts)
  end
})
