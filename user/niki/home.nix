{ pkgs, userPath, ... }:

{
	imports = [
		(userPath + /shared/shared.nix)
		./x.nix
		./mpd.nix
		./tmux.nix
		./vim.nix
	];

	home.stateVersion = "23.11";

	home.packages = with pkgs; [
		kitty
		pass
		gnupg
		bottles
	];

	home.file = {
		".config/kitty".source = ./sources/kitty;
		".local/share/fonts".source = ./sources/fonts;
		".config/libvirt".source = ./sources/libvirt;
		".firejail/qutebrowser/.config/qutebrowser/config.py".source = ./sources/qutebrowser/config.py;
	};

	home.sessionVariables = {
		BROWSER = "librewolf";
		EDITOR = "nvim";
	};

	programs.zathura = {
		enable = true;
	};

	programs.git = {
		enable = true;
		lfs.enable = true;
		userName = "Niki";
		userEmail = "<>";
		extraConfig.credential.helper = "store";
	};

	programs.bash = {
		enable = true;
		historyFileSize = 0;
	};

	programs.home-manager.enable = true;
}
