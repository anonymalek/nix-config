{ pkgs, userPath, ... }:
let
	terminal = "kitty";
	browser = "brave";
in
{
	imports = [
		(userPath + /shared/shared.nix)
	];

	home.stateVersion = "23.11";

	home.packages = with pkgs; [
		neovim
	];

	home.file = {
		".config/awesome/".source = ./sources/awesome;
		".local/share/fonts".source = ./sources/fonts;
	};

	home.sessionVariables = {
		TERMINAL = "kitty";
		BROWSER = "brave";
		VISUAL = "rider";
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

			"p" = "cd ~/playground";
			"c" = "cd ~/playground/law/nix-config && ls -l";
		};
	};

	services.sxhkd = {
		enable = true;
		
		keybindings = {
			"super + m + p" = terminal + " pulsemixer";
			"super + Return" = terminal;
			"super + q" = browser;
			
			"super + shift + s" = "flameshot gui";
		};
	};

	programs.home-manager.enable = true;
}
