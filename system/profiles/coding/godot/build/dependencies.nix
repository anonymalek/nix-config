{ pkgs }:

let
	commonDependencies = with pkgs; [
		scons
		pkg-config
		xorg.libX11
		xorg.libXcursor
		xorg.libXi
		xorg.libXinerama
		xorg.libXrandr
		alsaLib
		freetype
		libpng
		libtheora
		libvorbis
		openssl
		zlib
		mesa
	];

	windowsDependencies = with pkgs; [
		mingwW64
		wine
		(pkgs.fetchFromGitHub {
			owner = "lhmouse";
			repo = "mcfgthread";
			rev = "v1.8-ga.2";
			# sha256 = "0z5l0a3p3x5fh7f1hxvznhnp0hwykkl9bh5wkw8h5wkgm3qaz1zn"; # Update this with the actual hash
		})
	];

	macosDependencies = with pkgs; [
		darwin.apple_sdk.frameworks.CoreAudio
		darwin.apple_sdk.frameworks.CoreGraphics
		darwin.apple_sdk.frameworks.CoreServices
		darwin.apple_sdk.frameworks.Foundation
		darwin.apple_sdk.frameworks.IOKit
	];

in
{
	common = commonDependencies;
	windows = windowsDependencies;
	macos = macosDependencies;
}
