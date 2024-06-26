{ pkgs, ... }:
{
	packages = with pkgs; [
		rustc cargo
		rust-analyzer
	];
}
