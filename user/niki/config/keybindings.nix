{ ... }:
let
	terminal = "kitty --directory ~/";
	browser = "librewolf";
	browser_new_window = "librewolf --new-window";
	dmenu_selector = "dmenu";
in
{
	services.sxhkd = {
		enable = true;

		keybindings = {
			"super + d" = "${browser_new_window} https://discord.com/app";
			"super + q" = "${browser}";
			"super + ctrl + q" = "qutebrowser";

			"super + a" = terminal + " pulsemixer";
			"super + Return" = "${terminal}";
			"super + shift + Return" = "${terminal} tmux";
			"super + ctrl + Return" = "${terminal} tmux attach";

			# "super + v" = "tempvm";
			# "super + shift + v" = "vmprompt";

			"super + e" = ''pass -c $(find .password-store/ -iname "*.gpg" | sed -e "s/\.password-store\///g" -e "s/\.gpg//g" | sort | ${dmenu_selector})'';
			"super + shift + m" = terminal + " ncmpcpp";
			"super + shift + s" = "flameshot gui";

			# slock
			"super + alt + 1" = "slock -m 'shutting down in 1 minute' -t 60 -c 'systemctl poweroff -i'";
			"super + alt + 2" = "slock -m 'shutting down in 5 minutes' -t ${toString (60 * 5)} -c 'systemctl poweroff -i'";
			"super + alt + 3" = "slock -m 'shutting down in 15 minutes' -t ${toString (60 * 15)} -c 'systemctl poweroff -i'";
			"super + alt + 4" = "slock -m 'shutting down in 30 minutes' -t ${toString (60 * 30)} -c 'systemctl poweroff -i'";
			"super + alt + 5" = "slock -m 'shutting down in 1 hour' -t ${toString (60 * 60 * 1)} -c 'systemctl poweroff -i'";
			"super + alt + 6" = "slock -m 'shutting down in 1 hour and 30 minutes' -t ${toString (60 * 30 * 3)} -c 'systemctl poweroff -i'";
			"super + alt + 7" = "slock -m 'shutting down in 3 hours' -t ${toString (60 * 60 * 3)} -c 'systemctl poweroff -i'";
			"super + alt + 8" = "slock -m 'shutting down in 6 hours' -t ${toString (60 * 60 * 6)} -c 'systemctl poweroff -i'";
			"super + alt + 9" = "slock -m 'shutting down in 12 hours' -t ${toString (60 * 60 * 12)} -c 'systemctl poweroff -i'";
			"super + alt + 0" = "slock -m 'shutting down in 24 hours' -t ${toString (60 * 60 * 24)} -c 'systemctl poweroff -i'";

			"super + alt + s" = "slock & sleep 0.5 && systemctl suspend";

			"super + alt + d" = "slock";

			"super + alt + f" = "slock -i -t ${toString (60 * 60 * 24)} -c 'systemctl poweroff -i'";

			"XF86MonBrightnessUp" = "brightnessctl s +10%";
			"XF86MonBrightnessDown" = "brightnessctl s 10%-";

			"XF86AudioRaiseVolume" = "pulsemixer --change-volume +5";
			"XF86AudioLowerVolume" = "pulsemixer --change-volume -5";
			"XF86AudioMute" = "pulsemixer --toggle-mute";

			"XF86AudioPlay" = "mpc toggle";
			"XF86AudioStop" = "mpc stop";

			"XF86AudioPrev" = "mpc next";
			"XF86AudioNext" = "mpc prev";

			"super + i" = "mpc prev";
			"super + o" = "mpc toggle";
			"super + p" = "mpc next";

			"super + w" = "surf localhost:8384";
		};
	};
}
