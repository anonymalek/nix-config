{ pkgs, firejailWrap, ... }:
{
	packages = firejailWrap.packages {
		firefox = {
			executable = "${pkgs.firefox}/bin/firefox";
			profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
			extraArgs = [
				"--dbus-user.talk=org.freedesktop.Notifications"
				"--mkdir=~/.firejail/firefox"
				"--private=~/.firejail/firefox"
				"--novideo"
			];
		};
	};
}
