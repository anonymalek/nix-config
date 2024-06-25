{ pkgs, ... }:
{
	packages = with pkgs; [
		python311
		pyright
	];
}
