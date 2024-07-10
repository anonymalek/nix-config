args@{ pkgs, userPath, ... }:
{
	imports = [
		(userPath + /shared/shared.nix)
	];

	home.stateVersion = "23.11";

	home.packages = with pkgs; [
		pass
		gnupg
		bottles
    zathura
	];

	home.sessionVariables = {
		BROWSER = "librewolf";
		EDITOR = "nvim";
	};

  services.unclutter = {
		enable = true;
		timeout = 2;
	};

  home.file.".config/libvirt/qemu.conf".source = ./qemu.conf;
  
	programs.home-manager.enable = true;
}
