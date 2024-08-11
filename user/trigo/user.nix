{ config, pkgs, userPath, ... }:
{
	profiles = [
		/coding/editor/rider
		/coding/editor/vscode
		/coding/godot/default
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

	username = "trigo";

	user = {
		description = "Grão";
		
		extraGroups = [ "networkmanager" "wheel" ];
		shell = "${pkgs.fish}/bin/fish";
		isNormalUser = true;
	};

	home = import ./home.nix {
		inherit config pkgs userPath;
	};
}
