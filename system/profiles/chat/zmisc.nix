{ pkgs, ... }:
{
	packages = with pkgs; [
		element-desktop
		gomuks

		weechat
		irssi

		profanity

		mumble
	];	
}
