args@{ config, pkgs, systemPath, ... }:
{
	imports = [
		(systemPath + /global.nix)

		(systemPath + /profiles/coding/framework/godot.nix)
		(systemPath + /profiles/coding/editor/rider.nix)
		(systemPath + /profiles/coding/basic.nix)
		
		(systemPath + /profiles/network/anonymous.nix)
		(systemPath + /profiles/network/zerotier.nix)
		(systemPath + /profiles/network/nordvpn.nix)
		
		(import (systemPath + /profiles/games/steam.nix) args).sys
		
		(systemPath + /profiles/core/desktop-tools.nix)
		(systemPath + /profiles/core/desktop.nix)

		(systemPath + /profiles/audio/jack-pipewire.nix)
		
		(systemPath + /profiles/chat/discord.nix)
		(systemPath + /profiles/chat/vesktop.nix)
		
		./desktop/hyprland/hyprland.nix

		./user.nix
	];
	
	time.timeZone = "America/Recife";
	
	environment.systemPackages = with pkgs; [
		oh-my-fish
		obs-studio
		bottles
		zoxide
		brave
		
		a2jmidid
		jack2
		
		gpu-screen-recorder-gtk
		gpu-screen-recorder
	];
}
