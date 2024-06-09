{ config, pkgs, systemPath, ... }:
{
	imports = [
		(systemPath + /global.nix)

		(systemPath + /profiles/coding/framework/godot.nix)
		(systemPath + /profiles/coding/framework/ctf.nix)
		(systemPath + /profiles/coding/basic.nix)
		
		(systemPath + /profiles/network/anonymous.nix)
		(systemPath + /profiles/network/zerotier.nix)
		
		(systemPath + /profiles/games/steam.nix)
		
		(systemPath + /profiles/core/desktop-tools.nix)
		(systemPath + /profiles/core/desktop.nix)
		(systemPath + /profiles/audio/pipewire.nix)
		
		(systemPath + /profiles/browsers/librewolf.nix)
		(systemPath + /profiles/chat/vesktop.nix)

		./user.nix
	];

	services.xserver = {
		xkb.layout = "us,br";
		xkb.options = "grp:alt_caps_toggle";

		displayManager.sddm.enable = true;
		windowManager.awesome.enable = true;
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
