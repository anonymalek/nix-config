{ pkgs, firejailWrap, ... }:
{
	packages = firejailWrap.packages {
        qutebrowser = {
            executable = "${pkgs.qutebrowser}/bin/qutebrowser";
            profile = "${pkgs.firejail}/etc/firejail/qutebrowser.profile";
            extraArgs = [
                "--dbus-user.talk=org.freedesktop.Notifications"
                "--mkdir=~/.firejail/qutebrowser"
                "--private=~/.firejail/qutebrowser"
                "--novideo"
            ];
        };
	};
}
