{ stdenv, pkgs }:
with pkgs;

stdenv.mkDerivation rec {
	name = "dmenu";

	src = ./.;

	nativeBuildInputs = [ gnumake glibc glibc.static xorg.libX11 xorg.libXinerama xorg.libXft fontconfig ];
	buildInputs = [ glibc.static ];

	buildPhase = "make";
	installPhase = "DESTDIR=$out make install";
}
