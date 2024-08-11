{ pkgs, ... }:
{
	services.xserver.desktopManager.plasma5.enable = true;
	services.displayManager.sddm.enable = true;
	services.xserver.enable = true;

	environment.systemPackages = with pkgs; [
		plasma5Packages.qtstyleplugin-kvantum
		plasma5Packages.lightly

		plasma5Packages.qt5.qtwebsockets 
		plasma5Packages.qtwebsockets
		libsForQt5.qtwebsockets
		qt5.qtwebsockets 

		python3Packages.websockets
		
		plasma5Packages.plasma-vault

		kdeconnect
		konsave
	];
}