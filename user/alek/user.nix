{ config, pkgs, ... }:
{
	users.users.alek = {
		description = "Artificio";
		
		extraGroups = [ "networkmanager" "wheel" "libvirtd" "nordvpn" "jackaudio" ];
		shell = "${pkgs.fish}/bin/fish";
		isNormalUser = true;
	};
	
	home-manager.users.alek = import ./home.nix;
}
