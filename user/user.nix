{ username, realname, email ? "<>", ... }:
{
	imports = [ ./home.nix ];

	home.username = username;

	programs.git = {
		enable = true;

		lfs.enable = true;

		userName = realname;
		userEmail = email;
	};
}
