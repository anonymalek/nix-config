{ pkgs, ... }:

let
	terminal = "kitty --directory ~/";
	browser = "brave";
in
{
	imports = [ ./../shared/all.nix ];

	home.stateVersion = "23.11";

	home.packages = with pkgs; [
		neovim
	];

	home.file = {
		".config/awesome/".source = ./sources/awesome;
		".local/share/fonts".source = ./sources/fonts;
	};

	home.sessionVariables = {
		BROWSER = "brave";
		EDITOR = "nvim";
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

	xsession.enable = true;

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

			"nxs" = "nix search nixpkgs";

			"p" = "cd ~/playground";
			"c" = "cd ~/playground/law/nix-config && ls -l";
		};

		historyFileSize = 420;
	};

	services.sxhkd = {
		enable = true;

		keybindings = {
			"super + q" = "${browser}";
			"super + a" = terminal + " pulsemixer";

			"super + shift + s" = "flameshot gui";
		};
	};

	programs.home-manager.enable = true;
}
