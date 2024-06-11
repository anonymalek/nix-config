{ pkgs, ... }:
{
	home.packages = with pkgs; [
		mpc-cli
	];

	services.mpd = {
		enable = true;
		musicDirectory = "~/playground/music";	
	};

	programs.ncmpcpp = {
		enable = true;
		mpdMusicDir = "~/playground/music";
	};
}
