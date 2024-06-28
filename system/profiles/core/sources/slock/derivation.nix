{ stdenv, pkgs }: stdenv.mkDerivation  {
	name = "slock";

	src = ./.;

	nativeBuildInputs = with pkgs; [
		gnumake
		glibc
		glibc.static
		xorg.libX11
		xorg.libXrandr
		xorg.libXext
		xorg.libXinerama
		xorg.libXft
		libxcrypt
		fontconfig
	];

	buildInputs = with pkgs; [
		glibc.static
	];

	buildPhase = "make";
	installPhase = "DESTDIR=$out make install";
}
