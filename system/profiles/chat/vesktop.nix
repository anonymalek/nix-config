{ pkgs, firejailWrap, ... }:
{
	packages = (firejailWrap.packages {
		vesktop = {
			executable = "${pkgs.vesktop}/bin/vesktop";
			extraArgs = [
				"--mkdir=~/.firejail/vesktop"
				"--private=~/.firejail/vesktop"
				"--noprofile"
				"--novideo"
			];
		};
	});
}
