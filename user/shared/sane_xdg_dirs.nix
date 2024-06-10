{ config, lib, ... }:
{
	xdg.userDirs = let home = config.home.homeDirectory; in {
		enable = true;
		music       = lib.mkDefault "${home}/.xdg/music";
		videos      = lib.mkDefault "${home}/.xdg/videos";
		desktop     = lib.mkDefault "${home}/.xdg/desktop";
		pictures    = lib.mkDefault "${home}/.xdg/pictures";
		documents   = lib.mkDefault "${home}/.xdg/documents";
		templates   = lib.mkDefault "${home}/.xdg/templates";
		publicShare = lib.mkDefault "${home}/.xdg/public";
	};
}
