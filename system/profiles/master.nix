{ master, ... }:

{
	services.gitolite = {
		enable = true;
		user = "git";
		adminPubkey = master.ssh;
	};

	services.openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = false;
		};
	};

	networking.extraHosts = ''
		127.0.0.1 master
	'';
}
