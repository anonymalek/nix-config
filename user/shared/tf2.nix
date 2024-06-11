{ config, lib, ... }:
{
	options.tf2cfgPath = lib.mkOption {
		type = lib.types.str;
		default = ".firejail/steam/.local/share/Steam/steamapps/common/Team Fortress 2/tf/cfg";
	};

	config.home.file = {
		"${config.tf2cfgPath}/autoexec.cfg".source = ./sources/tf2/autoexec.cfg;
		"${config.tf2cfgPath}/binds.cfg".source = ./sources/tf2/binds.cfg;
		"${config.tf2cfgPath}/defaultbinds.cfg".source = ./sources/tf2/defaultbinds.cfg;
		"${config.tf2cfgPath}/engineer.cfg".source = ./sources/tf2/engineer.cfg;
		"${config.tf2cfgPath}/gfx.cfg".source = ./sources/tf2/gfx.cfg;
		"${config.tf2cfgPath}/network.cfg".source = ./sources/tf2/network.cfg;
		"${config.tf2cfgPath}/settings.cfg".source = ./sources/tf2/settings.cfg;
	};
}
