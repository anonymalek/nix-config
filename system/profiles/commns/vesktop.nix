{ config, pkgs, ... }:
{
    programs.firejail = {
		wrappedBinaries = {
			vesktop = {
				executable = "${pkgs.vesktop}/bin/vesktop";
				extraArgs = [
					"--mkdir=~/.firejail_vesktop"
					"--private=~/.firejail_vesktop"
					
					"--noprofile"
					"--novideo"
				];
			};
		};
	};
}