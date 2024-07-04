{ pkgs, ... }:
{
	imports = [ ./build/alias.nix ];

	packages = with pkgs; [
		godot_4
	];
}
