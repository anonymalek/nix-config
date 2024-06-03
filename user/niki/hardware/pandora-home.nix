{ lib, ... }:

let
	reset = "xrandr --output eDP-1 --off --output HDMI-1 --off";
in
{
	services.sxhkd.keybindings = {
		"super + u" = "${reset} && xrandr --output HDMI-1 --off --output eDP-1 --auto --mode 1280x800";
		"super + shift + u" = "${reset} && xrandr --output eDP-1 --off --output HDMI-1 --auto";
		"super + Left" = "${reset} && xrandr --output eDP-1 --auto --mode 1280x800 --output HDMI-1 --auto --primary --left-of eDP-1";
		"super + Right" = "${reset} && xrandr --output eDP-1 --auto --mode 1280x800 --output HDMI-1 --auto --primary --right-of eDP-1";
		"super + Up" = "${reset} && xrandr --output eDP-1 --auto --mode 1280x800 --output HDMI-1 --auto --primary --above eDP-1";
		"super + Down" = "${reset} && xrandr --output eDP-1 --auto --mode 1280x800 --output HDMI-1 --auto --primary --below eDP-1";
		
		# standard binding also suspends, currently
		# doesn't work in pandora
		"super + alt + s" = lib.mkForce "slock";
	};
}
