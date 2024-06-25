{ pkgs, ... }:
{
	imports = [ ./tor.nix ];

	sys = {
		networking.networkmanager.ethernet.macAddress = "random";
		networking.networkmanager.wifi.macAddress = "random";
		networking.networkmanager.wifi.scanRandMacAddress = true;

		networking.networkmanager.settings.main.hostname-mode = "none";

		# NetworkManager doesn't allow globally
		# preventing hostname leakage on DHCP
		# for some fucking reason. There's
		# a decent demand for that and there
		# has been for quite a few years now.
		networking.hostName = pkgs.lib.mkForce "";
	};
}
