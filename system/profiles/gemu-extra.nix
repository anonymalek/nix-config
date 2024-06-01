{ config, lib, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		dolphin-emu
		cemu
		ryujinx

		xpra
		wineWowPackages.full
    ];
}
