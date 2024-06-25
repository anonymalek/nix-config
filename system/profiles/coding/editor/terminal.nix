{ pkgs, ...}:
{
	packages = with pkgs; [
		neovim
		helix
		tmux
	];
}
