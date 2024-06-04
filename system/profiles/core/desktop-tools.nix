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
		ark
		
		ffmpeg
		yt-dlp
		mpc-cli
	];
}