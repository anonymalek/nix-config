{ lib, ... }:
{
	allowedUnfree = [ "zerotierone" ];

	sys = {
		services.zerotierone = {
			enable = true;
			joinNetworks = [
				"c7c8172af136d5c1"
			];

			localConf = {
				settings = {
					allowTcpFallbackRelay = false;
				};
			};

			port = 25555;
		};

		# systemd.services.zerotierone.wantedBy = lib.mkForce [];
	};
}
