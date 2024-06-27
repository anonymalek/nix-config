{ config, pkgs, userPath, ... }:
{
	profiles = [
		/coding/framework/godot
		/coding/editor/rider
		/coding/basic
		
		/network/anonymous
		/network/zerotier
		/network/nordvpn
		
		/games/steam
		/games/alvr
		
		/core/desktop-tools
		/core/desktop

		/audio/jack-pipewire
		
		/chat/discord
		/chat/vesktop
	];

	username = "alek";

	user = {
		description = "Artificio";
		
		extraGroups = [ "networkmanager" "wheel" ];
		shell = "${pkgs.fish}/bin/fish";
		isNormalUser = true;
	};
	
	home = import ./home.nix {
		inherit config pkgs userPath;
	};
}
