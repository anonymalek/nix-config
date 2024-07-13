{ pkgs, ... }:
{
	packages = with pkgs; [
		texliveFull
		pandoc
		groff
	];
}
