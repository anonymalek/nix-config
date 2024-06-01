{ config, lib, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		nur.repos.LuisChDev.nordvpn
	];
	
	allowedUnfree = [ "nordvpn" ];
}
