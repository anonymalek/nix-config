{ pkgs, firejailWrap, ... }:
{
	packages = (with pkgs; [
		# tor intentionally kept
		# as a standalone program
		# and not a service.
		tor
		torsocks

	]) ++ (firejailWrap.packages {
			tor-browser = {
				executable = "${pkgs.tor-browser}/bin/tor-browser";
				profile = "${pkgs.firejail}/etc/firejail/tor-browser.profile";
				extraArgs = [
					"--novideo"
					"--mkdir=~/.firejail/tor-browser"
					"--private=~/.firejail/tor-browser"
				];
			};
		});

	sys = {
		programs.proxychains = {
			enable = true;
			proxyDNS = true;
			chain.type = "dynamic";
			proxies = {
				tor-service-proxy = {
					enable = true;
					type = "socks4";
					host = "127.0.0.1";
					port = 9050;
				};
				tor-browser-proxy = {
					enable = true;
					type = "socks4";
					host = "127.0.0.1";
					port = 9150;
				};
			};
		};
	};
}
