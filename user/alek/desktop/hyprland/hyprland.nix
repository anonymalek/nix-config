{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		wofi
	];
	
	programs.hyprland = {
		enable = true;
	};
}