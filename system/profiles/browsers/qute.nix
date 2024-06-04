{ config, pkgs, lib, ... }:
{
    programs.firejail.wrappedBinaries = {
        qutebrowser = {
            executable = "${pkgs.qutebrowser}/bin/qutebrowser";
            profile = "${pkgs.firejail}/etc/firejail/qutebrowser.profile";
            extraArgs = [
                "--dbus-user.talk=org.freedesktop.Notifications"
                "--mkdir=~/.firejail_qutebrowser"
                "--private=~/.firejail_qutebrowser"
                "--novideo"
            ];
        };
    };
}