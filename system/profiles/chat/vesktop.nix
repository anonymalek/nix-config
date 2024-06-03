{ config, pkgs, ... }:
{
	programs.firejail = {
		wrappedBinaries = {
			vesktop = {
				executable = "${pkgs.vesktop}/bin/vesktop";
				extraArgs = [
					"--mkdir=~/.firejail/vesktop"
					"--private=~/.firejail/vesktop"
					"--noprofile"
					"--novideo"
				];
			};
		};
	};
}