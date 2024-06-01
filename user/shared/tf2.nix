{ ... }:
{
	home.file = let
		tf2Root = ".firejail_steam/.local/share/Steam/steamapps/common/Team Fortress 2/tf/cfg";
	in {
		"${tf2Root}/autoexec.cfg".source = ./sources/tf2/autoexec.cfg;
		"${tf2Root}/binds.cfg".source = ./sources/tf2/binds.cfg;
		"${tf2Root}/defaultbinds.cfg".source = ./sources/tf2/defaultbinds.cfg;
		"${tf2Root}/engineer.cfg".source = ./sources/tf2/engineer.cfg;
		"${tf2Root}/gfx.cfg".source = ./sources/tf2/gfx.cfg;
		"${tf2Root}/network.cfg".source = ./sources/tf2/network.cfg;
		"${tf2Root}/settings.cfg".source = ./sources/tf2/settings.cfg;
	};
}
