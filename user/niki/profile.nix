args@{ pkgs, systemPath, userPath, ... }:
let
	law = import (systemPath + /law.nix) args;
in
{
	imports = [
		(law.makeSystemUserModule (import ./user.nix args))
	];

	services.xserver = {
		xkb.layout = "us,br";
		xkb.options = "grp:alt_caps_toggle";

		enable = true;
		windowManager.awesome.enable = true;
	};

	services.displayManager.sddm.enable = true;

	services.syncthing = {
		enable = true;
		user = "niki";
		dataDir = "/home/niki/playground/sync";
		configDir = "/home/niki/playground/sync/syncthing";
	};

	programs.firejail.wrappedBinaries.heroic = {
		executable = "${pkgs.heroic}/bin/heroic";
		extraArgs = [
			"--noprofile"
			"--mkdir=~/.firejail/heroic"
			"--private=~/.firejail/heroic"
			"--ipc-namespace"
			"--novideo"
		];
	};

	# Syncthing ports: 8384 for remote access to GUI
	# 22000 TCP and/or UDP for sync traffic
	# 21027/UDP for discovery
	# source: https://docs.syncthing.net/users/firewall.html
	networking.firewall.allowedTCPPorts = [ 22000 ];
	networking.firewall.allowedUDPPorts = [ 22000 21027 ];

	home-manager.backupFileExtension = "backup";
}
