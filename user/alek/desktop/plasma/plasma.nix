{ config, pkgs, ... }:
{
	services.xserver.enable = true;
	
	services.desktopManager.plasma6.enable = true;
	services.displayManager.sddm.enable = true;

	environment.systemPackages = with pkgs; [
		wallpaper-engine-kde-plugin
	];

	# References: https://github.com/brianIcke/nixos-conf/blob/226c97d1b78a527eb0126a7012e27d935d4b4da0/system/BrianTUX/pkgs/wallpaper-engine-plasma-plugin.nix#L37
	glslang-submodule = with pkgs; stdenv.mkDerivation {
		name = "glslang";
		installPhase = ''
		mkdir -p $out
		'';
		src = fetchFromGitHub {
			owner = "KhronosGroup";
			repo = "glslang";
			rev = "c34bb3b6c55f6ab084124ad964be95a699700d34";
			sha256 = "IMROcny+b5CpmzEfvKBYDB0QYYvqC5bq3n1S4EQ6sXc=";
		};
	};
	
	wallpaper-engine-kde-plugin = with pkgs; stdenv.mkDerivation rec {
		pname = "wallpaperEngineKde";
		version = "91d8e25c0c94b4919f3d110c1f22727932240b3c";
		src = fetchFromGitHub {
			owner = "Jelgnum";
			repo = "wallpaper-engine-kde-plugin";
		};
	};
}