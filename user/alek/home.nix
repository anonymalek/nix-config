{ pkgs, userPath, ... }:
let
	terminal = "kitty";
	browser = "brave";
	visual = "rider";
	editor = "nvim";
in
{
	imports = [
		(userPath + /shared/shared.nix)
		./desktop/plasma/dotfiles.nix
	];

	home.stateVersion = "23.11";

	home.packages = with pkgs; [
		neovim
	];

	home.file = {
		".config/awesome/".source = (userPath + /niki/sources/awesome);
	};

	home.sessionVariables = {
		TERMINAL = terminal;
		BROWSER = browser;
		VISUAL = visual;
		EDITOR = editor;
	};

	programs.rofi = {
		enable = true;
		font = pkgs.lib.mkDefault "monospace 14";
		terminal = "${pkgs.kitty}/bin/kitty";
		theme = pkgs.lib.mkDefault "Arc-Dark";

		plugins = with pkgs; [
			rofi-calc
		];
	};

	services.unclutter = {
		enable = true;
		timeout = 2;
	};

	programs.fish = {
		enable = true;
		shellAliases = {
			"ll" = "ls -l";
			"la" = "ls -la";
			".." = "cd ..";

			"nv" = "nordvpn";
			"nvc" = "nv c";
			"nvct" = "nv s obfuscate true; nvc";
			"nvcf" = "nv s obfuscate false; nvc";

			"omf-install" = "curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish";

			"cd" = "z";

			"p" = "cd ~/playground";
			"c" = "cd ~/playground/law/nix-config && ls -l";

			"nirofi" = "unir $(cat /home/alek/playground/law/nix-config/user/alek/sources/pkg-list | rofi -dmenu)";
		};
		shellInit = "zoxide init fish | source";
	};

	programs.home-manager.enable = true;
}
