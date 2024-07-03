{ pkgs }:

let
	commonDependencies = with pkgs; [
		libGL
		vulkan-loader
		xorg.libXext

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
		pkgsCross.mingwW64.buildPackages.gcc
		wine
		(pkgs.fetchFromGitHub {
			owner = "lhmouse";
			repo = "mcfgthread";
			rev = "v1.8-ga.2";
			sha256 = "sha256-VxgdIHo5RgW5skiWDixoK7CjF8ALNLGM9gVbch6jFBk=";
		})
	];

	macosDependencies = with pkgs; [
		# darwin.apple_sdk.frameworks.CoreAudio
		# darwin.apple_sdk.frameworks.CoreGraphics
		# darwin.apple_sdk.frameworks.CoreServices
		# darwin.apple_sdk.frameworks.Foundation
		# darwin.apple_sdk.frameworks.IOKit
	];

in
{
	common = commonDependencies;
	windows = windowsDependencies;
	macos = macosDependencies;
}
