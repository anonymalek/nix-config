{ config, pkgs, system, ... }:
with pkgs.lib;
{
	imports = [ <home-manager/nixos> ];

	options.allowedUnfree = pkgs.lib.mkOption { type = pkgs.lib.types.listOf pkgs.lib.types.str; default = [ ]; };
	
	config.nixpkgs.config = {
		packageOverrides = pkgs: {
			nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
				inherit pkgs;
			};
		};
		
		allowUnfreePredicate = pkg: pkgs.lib.elem (pkgs.lib.getName pkg) config.allowedUnfree;
	};

	options.hostname = pkgs.lib.mkOption { type = pkgs.lib.types.str; default = config.system.nixos.distroId; };

	config = {
		networking.hostName = config.hostname;
		networking.networkmanager.enable = true;

		time.timeZone = mkDefault "Universal";

		i18n.defaultLocale = mkDefault "en_US.UTF-8";

		i18n.extraLocaleSettings = mkDefault {
			LC_ADDRESS = "en_US.UTF-8";
			LC_IDENTIFICATION = "en_US.UTF-8";
			LC_MEASUREMENT = "en_US.UTF-8";
			LC_MONETARY = "en_US.UTF-8";
			LC_NAME = "en_US.UTF-8";
			LC_NUMERIC = "en_US.UTF-8";
			LC_PAPER = "en_US.UTF-8";
			LC_TELEPHONE = "en_US.UTF-8";
			LC_TIME = "en_US.UTF-8";
		};

		services.xserver.xkb.layout = mkDefault "us";

		environment = let
			ps1 = ''export PS1="\[\e[34m\]\u\[\e[m\]@${config.hostname}:\[\e[36m\]\W\[\e[m\] $ "'';
		in {
			systemPackages = with pkgs; [
				vim
				emacs
				nano
				micro

				tmux
				wget
				git
				unison
				tree
				ranger
				openssh
				openssl
				busybox
				file

				# Might need to add pinentry-program /run/current-system/sw/bin/pinentry
				# to ~/.gnupg/gpg-agent.conf
				gnupg
				pass
				pinentry-gtk2
			];
			
			interactiveShellInit = ''
				${ps1}
				export HOSTNAME="${config.hostname}"
			'';

			shellAliases = {
				"ps0" = ''export PS1="\[\e[34m\]\u\[\e[m\]@${config.hostname}:\[\e[36m\]\W\[\e[m\] \[\e[34m\](\A) \[\e[m\]$ "'';
				"ps1" = ps1;
				"ps2" = ''export PS1="[\W] $ "'';
				"ps3" = ''export PS1="$ "'';
			};
		};

		programs.firejail.enable = mkDefault true;

		programs.nix-ld.enable = mkDefault true;

		programs.nix-ld.libraries = with pkgs; [
			stdenv.cc.cc
			zlib
			fuse3
			icu
			zlib
			nss
			openssl
			curl
			expat
			libxkbcommon
			fontconfig
			xorg.libX11
			xorg.libXcursor
			xorg.libXext
			xorg.libXcomposite
			xorg.libXcursor
			xorg.libXdamage
			xorg.libXdmcp
			xorg.libXext
			xorg.libXfixes
			xorg.libXfont
			xorg.libXfont2
			xorg.libXft
			xorg.libXi
			xorg.libXinerama
			xorg.libXmu
			xorg.libXp
			xorg.libXpm
			xorg.libXpresent
			xorg.libXrandr
			xorg.libXrender
			xorg.libXres
			xorg.libXt
			xorg.libXtst
			xorg.libXv
			xorg.libXvMC
			xorg.libXxf86dga
			xorg.libXxf86misc
			xorg.libXxf86vm
			xorg.libxcb
			xorg.libxcvt
			xorg.libxkbfile
			xorg.libxshmfence
			godot_4
			gle glew glfw
			dotnet-sdk_8
		];

		system.stateVersion = "23.11";
		nix.settings.experimental-features = [ "nix-command" "flakes" ];
	};
}
