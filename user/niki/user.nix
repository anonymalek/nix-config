args@{ pkgs, userPath, systemPath, ... }:
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
		/chat/vesktop
		/audio/pulseaudio
	];

	username = "niki";

	user = {
		description = "Niki";
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};

	home = import ./home.nix args;
}

