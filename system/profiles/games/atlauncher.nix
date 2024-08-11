{ pkgs, firejailWrap, ... }:
{
	packages = firejailWrap.packages {
		atlauncher = {
			executable = "${pkgs.atlauncher}/bin/atlauncher";
			extraArgs = [
				"--mkdir=~/.firejail/atlauncher"
				"--private=~/.firejail/atlauncher"
				"--novideo"
			];
		};
	};

  sys = {
		programs.nix-ld.libraries = with pkgs; [
      xorg.libX11
      xorg.libXcursor
      xorg.libXext
      xorg.libXrender
      xorg.libXtst
      xorg.libXi
    ];
  };
}
