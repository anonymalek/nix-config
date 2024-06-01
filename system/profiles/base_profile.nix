{ username ? "user", realname ? "User", modules ? [ "./global.nix" ], home-modules ? [], config, pkgs, ... }:
{
	users.users.${username} = {
		isNormalUser = true;
		description = realname;
		extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" ];
		packages = with pkgs; [];
	};

	home-manager.users.${username} = import ./../../user/user.nix {
		username = username;
		realname = realname;
		inherit home-modules;
	};

	home-manager.users.root = import ../../user/user.nix {
		username = "root";
		realname = realname;
		inherit home-modules;
	};

	environment.systemPackages = with pkgs; [
		neofetch
		tldr
	];
	
	services.xserver = {
		xkb.layout = "br";
	#	xkb.options = "grp:alt_caps_toggle";
	};

	services.syncthing = {
		enable = true;
		user = username;
		dataDir = "/home/${username}/playground/sync";
		configDir = "/home/${username}/playground/sync/syncthing";
	};

	# Syncthing ports: 8384 for remote access to GUI
	# 22000 TCP and/or UDP for sync traffic
	# 21027/UDP for discovery
	# source: https://docs.syncthing.net/users/firewall.html
	networking.firewall.allowedTCPPorts = [ 22000 ];
	networking.firewall.allowedUDPPorts = [ 22000 21027 ];

	imports = modules;
}
