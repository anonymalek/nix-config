{ ... }:
{
	programs.nixvim = {
		enable = true;

		viAlias = true;
		vimAlias = true;

		clipboard = {
			register = "unnamedplus";
			providers = {
				xclip.enable = true;
				wl-copy.enable = true;
			};
		};

		colorschemes = {
			catppuccin.enable = true;
			gruvbox.enable = true;
		};

		colorscheme = "gruvbox";

		opts = {
			number = true;
			relativenumber = true;

			autoindent = true;
			expandtab = false;
			tabstop = 4;
			shiftwidth = 4;

			scrolloff = 10;
		};

		globals.mapleader = " ";

		autoCmd = [
			{
				command = "set ai noet ts=4 sw=4";

				event = [
					"BufEnter"
					"BufWinEnter"
				];

				pattern = [
					"*"
				];
			}
		];


		plugins = {
			nix.enable = true;
			nix-develop.enable = true;

			tmux-navigator.enable = true;
			fugitive.enable = true;
			neo-tree.enable = true;

			fzf-lua = {
				enable = true;
				iconsEnabled = true;
			};

			treesitter.enable = true;
			treesitter-context.enable = true;

			comment = {
				enable = true;
				settings = {
					mappings = {
						basic = true;
						extra = false;
					};

					toggler = {
						line = "<C-c>";
						block = "<C-x>";
					};

					opleader = {
						line = "<C-C>";
						block = "<C-X>";
					};
				};
			};

			lsp = {
				enable = true;
				
				servers = {
					nixd.enable = true;
					pyright.enable = true;
					clangd.enable = true;
					bashls.enable = true;
					rust-analyzer = {
						enable = true;
						installCargo = false;
						installRustc = false;
					};
				};
			};
		};

		keymaps = [
			# { action = "<cmd>redo<CR>";
			#   key = "U";
			#   mode = [ "n" "v" ]; }
			
			{ action = "<cmd>Neotree toggle<CR>";
			  key = "<Leader>a";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>FzfLua live_grep<CR>";
			  key = "<Leader>G";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>FzfLua lines<CR>";
			  key = "<Leader>g";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>FzfLua buffers<CR>";
			  key = "<Leader>b";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>FzfLua files<CR>";
			  key = "<Leader>f";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>FzfLua git_status<CR>";
			  key = "<Leader>J";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>Neotree git_status<CR>";
			  key = "<Leader>j";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>FzfLua marks<CR>";
			  key = "<Leader>m";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>FzfLua colorschemes<CR>";
			  key = "<Leader>z";
			  mode = [ "n" "v" ]; }

			# LSP
			{ action = "<cmd>FzfLua lsp_document_symbols<CR>";
			  key = "<Leader>s";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>FzfLua lsp_workspace_symbols<CR>";
			  key = "<Leader>S";
			  mode = [ "n" "v" ]; }

			# { action = "<cmd>FzfLua diagnostics_document<CR>";
			{ action = "<cmd>lua vim.diagnostic.setloclist()<CR>";
			  key = "<Leader>w";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>FzfLua diagnostics_workspace<CR>";
			  key = "<Leader>W";
			  mode = [ "n" "v" ]; }

			# { action = "<cmd>FzfLua lsp_code_actions<CR>";
			{ action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
			  key = "<Leader>c";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>lua vim.lsp.buf.definition()<CR>";
			  key = "gd";
			  mode = [ "n" ]; }

			{ action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
			  key = "gD";
			  mode = [ "n" ]; }

			# { action = "<cmd>FzfLua lsp_references<CR>";
			{ action = "<cmd>lua vim.lsp.buf.references()<CR>";
			  key = "gr";
			  mode = [ "n" ]; }
			
			{ action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
			  key = "gi";
			  mode = [ "n" ]; }

			{ action = "<cmd>lua vim.diagonostic.goto_prev()<CR>";
			  key = "[d";
			  mode = [ "n" "v" ]; }

			{ action = "<cmd>lua vim.diagonostic.goto_next()<CR>";
			  key = "]d";
			  mode = [ "n" "v" ]; }
		];
	};
}
