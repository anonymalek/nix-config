{ pkgs, firejailWrap, ... }:
{
	packages = firejailWrap.packages {
		librewolf = {
			executable = "${pkgs.librewolf}/bin/librewolf";
			profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
			extraArgs = [
				"--dbus-user.talk=org.freedesktop.Notifications"
				"--mkdir=~/.firejail/librewolf"
				"--private=~/.firejail/librewolf"
				"--novideo"
			];
		};
	};
}
