{ pkgs ? import <nixpkgs> {} }:

let
	deps = import ./dependencies.nix { inherit pkgs; };
	allDependencies = deps.common ++ deps.windows ++ deps.macos;
in

pkgs.stdenv.mkDerivation {
	pname = "godot";
	version = "latest";

	src = "$PWD";

	buildInputs = allDependencies;

	buildPhase = ''
	scons platform=linuxbsd
	'';

	installPhase = ''
	mkdir -p $out/bin
	cp bin/godot.x11.opt.tools.64 $out/bin/godot
	'';

	meta = with pkgs.lib; {
	description = "Godot Engine | Custom";
	homepage = https://godotengine.org/;
	license = licenses.mit;
	maintainers = with maintainers; [];
	};
}
