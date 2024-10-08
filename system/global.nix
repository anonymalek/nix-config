{ config, pkgs, ... }:
{
	options.allowedUnfree = pkgs.lib.mkOption {
		type = pkgs.lib.types.listOf pkgs.lib.types.str;
		default = [ ];
	};

	config.nixpkgs.config = {
		allowUnfreePredicate = pkg: pkgs.lib.elem (pkgs.lib.getName pkg) config.allowedUnfree;
	};

	options.hostname = pkgs.lib.mkOption {
		type = pkgs.lib.types.str;
		default = config.system.nixos.distroId;
	};

	config = {
		networking.hostName = pkgs.lib.mkDefault config.hostname;
		networking.networkmanager.enable = pkgs.lib.mkDefault true;

		time.timeZone = pkgs.lib.mkDefault "Universal";

		i18n.defaultLocale = pkgs.lib.mkDefault "en_US.UTF-8";

		i18n.extraLocaleSettings = pkgs.lib.mkDefault {
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

		services.xserver.xkb.layout = pkgs.lib.mkDefault "us";

		environment = {
			systemPackages = with pkgs; [
				(writeShellScriptBin "punir" ''NIXPKGS_ALLOW_BROKEN=1 NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 NIXPKGS_ALLOW_UNFREE=1 nix run nixpkgs#$1 --impure -- ''${@:2}'')
				(writeShellScriptBin "unir" ''NIXPKGS_ALLOW_UNFREE=1 nix run nixpkgs#$1 --impure -- ''${@:2}'')
				(writeShellScriptBin "nir" ''nix run nixpkgs#$1 -- ''${@:2}'')
				(writeShellScriptBin "nxs" ''nix search nixpkgs $@'')


				(writeShellScriptBin "nrb" ''/conf/rebuild.sh'')
				(writeShellScriptBin "ncrb" ''nix-collect-garbage -d && sudo nix-collect-garbage -d && /conf/rebuild.sh'')

				(writeShellScriptBin "warp" ''nix-shell /etc/nixos/system/environments/$1.nix && echo "warped out"'')


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
				pinentry-gtk2
			];

			variables = {
				HOSTNAME = "${config.hostname}";
			};
		};

		programs.dconf.enable = pkgs.lib.mkDefault true;
		programs.firejail.enable = pkgs.lib.mkDefault true;

		system.stateVersion = "23.11";
		nix.settings.experimental-features = [ "nix-command" "flakes" ];

		programs.nix-ld.enable = true;
	};
}
