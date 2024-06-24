{ config, pkgs, law, ... }:
let
	firejailData = let steamExtraArgs = [
		"--mkdir=~/.firejail/steam"
		"--private=~/.firejail/steam"
		"--novideo"
	]; in {
		steam = {
			executable = "${pkgs.steam}/bin/steam";
			profile = "${pkgs.firejail}/etc/firejail/steam.profile";
			extraArgs = steamExtraArgs;
		};
		steamcmd = {
			executable = "${pkgs.steamcmd}/bin/steamcmd";
			profile = "${pkgs.firejail}/etc/firejail/steam.profile";
			extraArgs = steamExtraArgs;
		};
	};
in
rec {
	allowedUnfree = [
		"steam"
		"steam-original"
		"steam-run"
		"steamcmd"
	];

	sys = {
		allowedUnfree = allowedUnfree;

		environment.systemPackages = with pkgs; [
			steamcmd
		];

		# # Required for Steam
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
		
		programs.steam = {
			enable = true;
			remotePlay.openFirewall = true;
			dedicatedServer.openFirewall = true;
			localNetworkGameTransfers.openFirewall = true;
		};

		programs.firejail.wrappedBinaries = (law.firejailWrapSys firejailData);
	};

	home = {
		home.packages = [
			pkgs.steam
			pkgs.steamcmd
		] ++ (law.firejailWrapPkgs firejailData);
	};
}
