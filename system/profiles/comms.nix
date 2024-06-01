{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		element-desktop
		gomuks

		weechat
		irssi

		profanity

		mumble
	];

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
