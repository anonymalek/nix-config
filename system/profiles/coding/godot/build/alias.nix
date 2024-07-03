{ pkgs, ... }:
{
	packages = [
		(pkgs.writeShellScriptBin "godotc-shell" ''
			nix-shell ${./.}/shell.nix
		'')

		(pkgs.writeShellScriptBin "godotc-build" ''
			nix-build ${./.}/build.nix
		'')
	];
}