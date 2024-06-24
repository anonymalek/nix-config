args@{ pkgs, userPath, systemPath, ... }:
{
	profiles = [
		# /network/anonymous
		# /network/zerotier
		# /coding/framework/godot
		# /coding/basic
		/games/steam
		# /chat/vesktop
		# /audio/jack-pipewire
	];

	username = "niki";

	user = {
		description = "Niki";
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "audio" "libvirtd" ];
	};

	home = import ./home.nix args;
}

