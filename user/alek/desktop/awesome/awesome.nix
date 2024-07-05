{ pkgs, ... }:
{
	services.xserver.windowManager.awesome = true;
	services.displayManager.sddm.enable = true;
	services.xserver.enable = true;

	environment.systemPackages = with pkgs; [
		systemsettings
		dolphin
		konsole
	];
}