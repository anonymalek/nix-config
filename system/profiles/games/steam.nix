{ config, lib, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		steamcmd
	];

	# Required for Steam
	hardware.opengl.driSupport32Bit = true;
	hardware.pulseaudio.support32Bit = true;

	# https://github.com/ValveSoftware/Source-1-Games/issues/5043#issuecomment-1822019817
	# Launch options: LD_PRELOAD="/usr/lib32/libtcmalloc_minimal.so:$LD_PRELOAD" %command%
	nixpkgs.overlays = [
		(final: prev: {
			steam = prev.steam.override ({ extraLibraries ? pkgs': [], ... }: {
				extraLibraries = pkgs': (extraLibraries pkgs') ++ ( [
					pkgs'.gperftools
				]);
			});
		})
	];

	allowedUnfree = [
		"steam"
		"steam-original"
		"steam-run"
		"steamcmd"
		"zerotierone"
	];

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

	programs.firejail = {
		enable = true;
		wrappedBinaries = let
			steamExtraArgs = [
				"--mkdir=~/.firejail/steam"
				"--private=~/.firejail/steam"
				"--novideo"
			];
		in {
			steam = {
				executable = "${pkgs.steam}/bin/steam";
				profile = "${pkgs.firejail}/etc/firejail/steam.profile";
				extraArgs = steamExtraArgs;
			};

			steam-run = {
				executable = "${pkgs.steam}/bin/steam-run";
				profile = "${pkgs.firejail}/etc/firejail/steam.profile";
				extraArgs = steamExtraArgs;
			};

			steamcmd = {
				executable = "${pkgs.steamcmd}/bin/steamcmd";
				profile = "${pkgs.firejail}/etc/firejail/steam.profile";
				extraArgs = steamExtraArgs;
			};

			heroic = {
				executable = "${pkgs.heroic}/bin/heroic";
				extraArgs = [
					"--noprofile"
					"--mkdir=~/.firejail/heroic"
					"--private=~/.firejail/heroic"

					"--ipc-namespace"
					"--novideo"
				];
			};
		};
	};
}
