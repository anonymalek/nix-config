{ lib, ... }:
{
	allowedUnfree = [ "zerotierone" ];

	sys = {
		services.zerotierone = {
			enable = true;
		};

		systemd.services.zerotierone.wantedBy = lib.mkForce [];
	};
}
