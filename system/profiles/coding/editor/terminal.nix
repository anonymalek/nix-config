{ config, pkgs, ...}:
{
	environment.systemPackages = with pkgs; [
		neovim
		helix
		tmux
	];
}
