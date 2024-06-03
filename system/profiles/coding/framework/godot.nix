{ config, lib, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		godot_4
	];
}
