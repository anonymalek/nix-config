args@{ pkgs, userPath, systemPath, ... }:
{
	profiles = [
		/core/desktop
		/core/desktop-tools
		/browsers/librewolf
		/network/anonymous
		/network/zerotier
		/coding/framework/godot
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

