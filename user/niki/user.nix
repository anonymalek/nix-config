args@{ pkgs, lib, userPath, systemPath, ... }:
{
	profiles = [
		/core/desktop
		/core/desktop-tools
		/browsers/librewolf
		/browsers/qute
		/network/anonymous
		/network/zerotier
		/coding/godot/default
		/coding/basic
		/games/steam
		/games/atlauncher
		/chat/vesktop
		/audio/pulseaudio
	];

	username = "niki";

	user = {
		description = "Niki";
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};

	home = import ./home.nix {
		inherit pkgs lib userPath systemPath;
	};
}

