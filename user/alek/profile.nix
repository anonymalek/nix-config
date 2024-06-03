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
		./../../system/profiles/chat/discord.nix
		./../../system/profiles/chat/vesktop.nix
	];
	
	users.users.alek = {
		description = "Artificio";
		
		extraGroups = [ "networkmanager" "wheel" "libvirtd" "nordvpn" ];
		shell = "${pkgs.fish}/bin/fish";
		isNormalUser = true;
	};
	
	home-manager.users.alek = import ./home.nix;
	
	nixpkgs.config.packageOverrides = pkgs: {
		nordvpn = config.nur.repos.LuisChDev.nordvpn;
	};

	services.nordvpn.enable = true;
	
	environment.systemPackages = with pkgs; [
		qt6Packages.qtstyleplugin-kvantum
		brave
	];
	
	services.xserver = {
		enable = true;
	};
	
	services.desktopManager.plasma6.enable = true;
	services.displayManager.sddm.enable = true;
}