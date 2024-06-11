{ config, pkgs, userPath, ... }:
{
	users.users.niki = {
		description = "Niki";
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" ];
	};

	home-manager.users.niki = import ./home.nix {
		inherit config pkgs userPath;
	};
}
