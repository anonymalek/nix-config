{ config, lib, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		neovim
		helix

		clang
		clang-tools

		rustc cargo
		rust-analyzer

		python3
		pyright

		nixd

		gdb
		tmux		
	];
}
