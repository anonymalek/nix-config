{ config, lib, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		python311
		pyright
	];
}
