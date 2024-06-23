{ config, lib, pkgs, ... }:
{
    services.zerotierone = {
		enable = true;
	};

	allowedUnfree = [ "zerotierone" ];

	systemd.services.zerotierone.wantedBy = lib.mkForce [];
}
