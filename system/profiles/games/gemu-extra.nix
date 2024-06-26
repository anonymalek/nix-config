{ pkgs, ... }:
{
	packages = with pkgs; [
		dolphin-emu
		cemu
		ryujinx

		xpra
		wineWowPackages.full
    ];
}
