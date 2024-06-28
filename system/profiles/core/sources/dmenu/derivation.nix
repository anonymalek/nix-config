{ stdenv, pkgs }: stdenv.mkDerivation {
	name = "dmenu";

	src = ./.;

	nativeBuildInputs = with pkgs; [
		gnumake
		glibc
		glibc.static
		xorg.libX11
		xorg.libXinerama
		xorg.libXft
		fontconfig
	];

	buildInputs = with pkgs; [
		glibc.static
	];

	buildPhase = "make";
	installPhase = "DESTDIR=$out make install";
}
