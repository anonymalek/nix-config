{ config, pkgs, ... }:
{
	users.users.niki = {
		isNormalUser = true;
		description = "Niki";
		extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" ];
		packages = with pkgs; [];
	};

	home-manager.users.niki = import ./../../user/user.nix {
		username = "niki";
		realname = "Niki";
	};

	home-manager.users.root = import ../../user/user.nix {
		username = "root";
		realname = "Niki";
	};

	environment.systemPackages = with pkgs; [
		neofetch
		tldr
	];
	
	services.xserver = {
		xkb.layout = "us,ru,br";
		xkb.options = "grp:alt_caps_toggle";
	};

	services.syncthing = {
		enable = true;
		user = "niki";
		dataDir = "/home/niki/playground/sync";
		configDir = "/home/niki/playground/sync/syncthing";
	};

	# Syncthing ports: 8384 for remote access to GUI
	# 22000 TCP and/or UDP for sync traffic
	# 21027/UDP for discovery
	# source: https://docs.syncthing.net/users/firewall.html
	networking.firewall.allowedTCPPorts = [ 22000 ];
	networking.firewall.allowedUDPPorts = [ 22000 21027 ];

	imports = [
		./global.nix
		./desktop.nix
		./desktop-tools.nix
		./code.nix
		./comms.nix
		./ctf.nix
		./game.nix
		./anonymous.nix
		./virtualization.nix
	];
}
