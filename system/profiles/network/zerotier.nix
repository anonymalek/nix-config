{ config, lib, pkgs, ... }:
{
    services.zerotierone = {
		enable = true;
	};
	
	networking.firewall = {
        checkReversePath = false;
        allowedTCPPorts = [ 443 ];
        allowedUDPPorts = [ 1194 ];
	};

	systemd.services.zerotierone.wantedBy = lib.mkForce [];
}
