args@{ pkgs, lib, nixvim, userPath, systemPath, ... }:
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
		/coding/framework/ctf
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
		inherit pkgs lib nixvim userPath systemPath;
	};
}

