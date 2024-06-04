{ config, pkgs, ... }:
#let
#	wallpaper-engine-plasma-plugin = pkgs.plasma5Packages.callPackage ./wallpaper-engine-plasma-plugin.nix {
#		inherit (pkgs.gst_all_1) gst-libav;
#		inherit (pkgs.python3Packages) websockets;
#	};
#in
{
	services.xserver.enable = true;
	
	services.desktopManager.plasma6.enable = true;
	services.displayManager.sddm.enable = true;

#	environment.systemPackages = [
#		wallpaper-engine-plasma-plugin
#	];
}