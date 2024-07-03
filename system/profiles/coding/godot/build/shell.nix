{ pkgs ? import <nixpkgs> {} }:

let
	deps = import ./dependencies.nix { inherit pkgs; };
	allDependencies = deps.common ++ deps.windows ++ deps.macos;
in

pkgs.mkShell {
	buildInputs = allDependencies;

	shellHook = ''
		echo "Welcome to the Godot development shell"
	'';
}
