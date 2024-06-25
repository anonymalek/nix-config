{ pkgs, ... }:
{
	packages = with pkgs; [
		clang-tools
		clang
		gcc
		
		gnumake
		cmake
		scons
		
		gdb
	];
}
