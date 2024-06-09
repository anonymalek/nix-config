{ pkgs, ... }:
{
	imports = [ ./tf2.nix ];
		
	home.packages = with pkgs; [
		(writeShellScriptBin "unir" ''NIXPKGS_ALLOW_UNFREE=1 nir'')
		(writeShellScriptBin "nir" ''nix run nixpkgs#$1 -- ''${@:2}'')
	];

	home.file.".gnupg/gpg-agent.conf".text = "pinentry-program /run/current-system/sw/bin/pinentry";
}
