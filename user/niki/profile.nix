{ config, pkgs, ... }:
{
	imports = [
		./../../system/global.nix

		./../../system/profiles/coding/framework/godot.nix
		./../../system/profiles/coding/basic.nix
		
		./../../system/profiles/network/anonymous.nix
		./../../system/profiles/network/zerotier.nix
		
		./../../system/profiles/games/steam.nix
		
		./../../system/profiles/core/desktop-tools.nix
		./../../system/profiles/core/desktop.nix
		./../../system/profiles/audio/pipewire.nix
		
		./../../system/profiles/browsers/librewolf.nix
		./../../system/profiles/chat/vesktop.nix
	];

	users.users.niki = {
		description = "Niki";
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" ];
	};

	home-manager.users.niki = import ./home.nix;

	services.xserver = {
		xkb.layout = "us,br";
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
}
