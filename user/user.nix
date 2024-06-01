{ username, realname, home-modules ? [], email ? "<>", ... }:
{
	imports = home-modules;

	home.username = username;

	programs.git = {
		enable = true;

		lfs.enable = true;

		userName = realname;
		userEmail = email;
	};
}
