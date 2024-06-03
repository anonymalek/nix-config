{ config, lib, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		clang-tools
		clang
		gcc
		
		gnumake
		cmake
		scons
		
		gdb
	];
}
