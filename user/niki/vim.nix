{ pkgs, ... }:
{
	home.packages = with pkgs; [
		vim
		neovim
	];

	home.file = {
		".vimrc".source = ./sources/vim/vimrc;
		".config/nvim".source = ./sources/vim;
	};
}
