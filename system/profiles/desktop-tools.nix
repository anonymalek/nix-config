{ config, pkgs, lib, ... }:
{
	environment.systemPackages = with pkgs; [
		libreoffice
		surf
		gimp
		audacity
		sxiv
		zathura
		mpv
		flameshot

		ffmpeg
		yt-dlp
		mpc-cli
	];
}
