args@{ pkgs, userPath, ... }:
{
	imports = [
		(userPath + /shared/shared.nix)

		./config/x.nix
		./config/mpd.nix
		./config/tmux.nix
		./config/vim.nix
		./config/kitty.nix
	];

	home.stateVersion = "23.11";

	home.packages = with pkgs; [
		pass
		gnupg
		bottles
	];

	home.file = {
		".local/share/fonts".source = ./config/sources/fonts;
		".config/libvirt".source = ./config/sources/libvirt;
		".firejail/qutebrowser/.config/qutebrowser/config.py".source = ./config/sources/qutebrowser/config.py;
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
