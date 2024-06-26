{ ... }:
{
	imports = [ ./keybindings.nix ];

	xsession = {
		enable = true;
		windowManager.awesome.enable = true;
	};

	home.file = {
		".config/awesome/".source = ./sources/awesome;
	};

	services.unclutter = {
		enable = true;
		timeout = 2;
	};
}
