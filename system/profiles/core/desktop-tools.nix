{ pkgs, ... }:
{
	packages = with pkgs; [
		libreoffice
		surf
		gimp
		krita
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
