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
	];
	
	time.timeZone = "America/Recife";
	
	users.users.alek = {
		description = "Artificio";
		
		extraGroups = [ "networkmanager" "wheel" "libvirtd" "nordvpn" "jackaudio" ];
		shell = "${pkgs.fish}/bin/fish";
		isNormalUser = true;
	};
	
	home-manager.users.alek = import ./home.nix;
	
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
