{ config, lib, pkgs, nixpkgs-unstable, ... }:
let
	srcpkgs = {
		slock = (pkgs.callPackage ./sources/slock/derivation.nix {});
		dmenu = (pkgs.callPackage ./sources/dmenu/derivation.nix {});
	};
in
{
	environment.systemPackages = with pkgs; [
		srcpkgs.slock
		srcpkgs.dmenu
		xwallpaper
		brightnessctl
		rofi
		kitty
		pulsemixer
		xpra
	];

	fonts.packages = with pkgs; [
		nerdfonts
		jetbrains-mono
		noto-fonts
		dejavu_fonts
		terminus_font_ttf
	];

	security.wrappers.slock = {
		setuid = true;
		owner = "root";
		group = "root";
		source = "${srcpkgs.slock.out}/bin/slock";
	};

	services.xserver =
	{
		enable = true;
		extraConfig = ''
			Section "ServerFlags"
				Option "DontVTSwitch" "True"
				Option "DontZap"      "True"
			EndSection
		'';
	};
}
