{ lib, ... }:
{
	allowedUnfree = [ "zerotierone" ];

	sys = {
		services.zerotierone = {
			enable = true;
			joinNetworks = [
				"c7c8172af136d5c1"
			];
		};

		systemd.services.zerotierone.wantedBy = lib.mkForce [];
	};
}
