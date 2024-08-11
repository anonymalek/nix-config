args@{ config, pkgs, systemPath, ... }:
let
	law = import (systemPath + /law.nix) args;
in
{
	imports = [
		./desktop/hyprland/hyprland.nix
		./desktop/plasma/plasma.nix

		(law.makeSystemUserModule (import ./user.nix args))
	];
	
	time.timeZone = "America/Recife";
}
