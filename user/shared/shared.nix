{ pkgs, ... }:
{
	imports = [ ./tf2.nix ];
		
	home.packages = with pkgs; [
		(writeShellScriptBin "unir" ''NIXPKGS_ALLOW_UNFREE=1 nir'')
		(writeShellScriptBin "nir" ''nix run nixpkgs#$1 -- ''${@:2}'')
	];
}
