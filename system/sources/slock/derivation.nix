{ stdenv, pkgs }:
with pkgs;

stdenv.mkDerivation rec {
	name = "slock";

	src = ./.;

	nativeBuildInputs = [ gnumake glibc glibc.static xorg.libX11 xorg.libXrandr xorg.libXext xorg.libXinerama xorg.libXft libxcrypt fontconfig ];
	buildInputs = [ glibc.static ];

	buildPhase = "make";
	installPhase = "DESTDIR=$out make install";
}
