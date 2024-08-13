{ pkgs, ... }:
{
	packages = with pkgs; [
		clang-tools
		clang
		gcc14
		
		gnumake
		cmake
		scons
    ninja
		
		gdb
	];
}
