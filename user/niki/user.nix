args@{ pkgs, userPath, systemPath, ... }:
{
	profiles = [
		/core/desktop
		/core/desktop-tools
		/browsers/librewolf
		/network/anonymous
		/network/zerotier
		/network/nordvpn
		/coding/framework/godot
		/coding/basic
		/games/steam
		/chat/vesktop
		# /audio/pulseaudio
		/audio/jack-pipewire
	];

	username = "niki";

	user = {
		description = "Niki";
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};

	home = import ./home.nix args;
}

