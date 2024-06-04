{ config, lib, pkgs, ... }:
{
    services.zerotierone = {
		enable = true;
	};

	systemd.services.zerotierone.wantedBy = lib.mkForce [];
}
