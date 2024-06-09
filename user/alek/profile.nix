{ config, pkgs, ... }:
{
	imports = [
		./../../system/profiles/coding/framework/godot.nix
		./../../system/profiles/coding/editor/rider.nix
		./../../system/profiles/coding/basic.nix
		
		./../../system/profiles/network/anonymous.nix
		./../../system/profiles/network/zerotier.nix
		./../../system/profiles/network/nordvpn.nix
		
		./../../system/profiles/games/steam.nix
		
		./../../system/profiles/core/desktop-tools.nix
		./../../system/profiles/core/desktop.nix
		
		./../../system/profiles/audio/jack-pipewire.nix
		
		./../../system/profiles/chat/discord.nix
		./../../system/profiles/chat/vesktop.nix
		
		./desktop/hyprland/hyprland.nix
		./desktop/plasma/plasma.nix

		./user.nix
	];
	
	time.timeZone = "America/Recife";
	
	environment.systemPackages = with pkgs; [
		oh-my-fish
		obs-studio
		bottles
		zoxide
		brave
		
		jack2
		a2jmidid
	];
}
