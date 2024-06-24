vim.cmd("source ~/.vimrc")

local vim = vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")
	Plug("https://github.com/preservim/nerdtree")
	Plug("https://github.com/neovim/nvim-lspconfig")
	Plug("https://github.com/numToStr/Comment.nvim")
	Plug("https://github.com/mfussenegger/nvim-dap")

	Plug("https://github.com/junegunn/fzf", { ["do"] = function()
		vim.fn["fzf#install"]()
	end })
	-- Plug("https://github.com/junegunn/fzf.vim")
	Plug("https://github.com/ibhagwan/fzf-lua")

	Plug("https://github.com/echasnovski/mini.completion")

	Plug("hrsh7th/cmp-nvim-lsp")
	Plug("hrsh7th/cmp-buffer")
	Plug("hrsh7th/cmp-path")
	Plug("hrsh7th/cmp-cmdline")
	Plug("hrsh7th/nvim-cmp")

	Plug("https://github.com/dcampos/nvim-snippy")
	Plug("https://github.com/dcampos/cmp-snippy")
	Plug("https://github.com/honza/vim-snippets")

	-- Themes
	Plug("https://github.com/catppuccin/nvim", { ["as"] = "catppuccin"})
vim.call("plug#end")

vim.cmd.colorscheme("default")
vim.g.mapleader = ' '

require("Comment").setup()

local lspconfig = require("lspconfig")
lspconfig.clangd.setup {}
lspconfig.nixd.setup {}

-- TODO: Clean up this mess :D

-- Set up nvim-cmp.
local cmp = require"cmp"

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			require("snippy").expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = "vsnip" }, -- For vsnip users.
		-- { name = "luasnip" }, -- For luasnip users.
		-- { name = "ultisnips" }, -- For ultisnips users.
		{ name = "snippy" }, -- For snippy users.
	}, {
		{ name = "buffer", keyword_length = 4 },
		{ name = "path" },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = "buffer" },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" }
	}
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" }
	}, {
		{ name = "cmdline" }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["clangd"].setup {
	capabilities = capabilities
}

require("lspconfig")["nixd"].setup {
	capabilities = capabilities
}

vim.keymap.set("n", "<Leader>f", "<cmd>FzfLua files<cr>")
vim.keymap.set("n", "<Leader>b", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<Leader>g", "<cmd>FzfLua live_grep<cr>")
vim.keymap.set("n", "<Leader>j", "<cmd>FzfLua git_status<cr>")
vim.keymap.set("n", "<Leader>m", "<cmd>FzfLua marks<cr>")
vim.keymap.set("n", "<Leader>z", "<cmd>FzfLua colorschemes<cr>")
vim.keymap.set("n", "<Leader>a", "<cmd>NERDTreeToggle<cr>")

-- LSP related

vim.keymap.set("n", "<Leader>d", "<cmd>FzfLua lsp_document_diagnostics<cr>")
vim.keymap.set("n", "<Leader>D", "<cmd>FzfLua lsp_workspace_diagnostics<cr>")

vim.keymap.set("n", "<Leader>s", "<cmd>FzfLua lsp_document_symbols<cr>")
vim.keymap.set("n", "<Leader>S", "<cmd>FzfLua lsp_workspace_symbols<cr>")

vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set({"n", "i"}, "<C-k>", vim.lsp.buf.signature_help)

vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename)
vim.keymap.set({"n", "v"}, "<Leader>c", vim.lsp.buf.code_action)

vim.cmd("nmap <C-c> gcc")
vim.cmd("nmap <C-x> gbc")
vim.cmd("vmap <C-c> gc")
vim.cmd("vmap <C-x> gb")

