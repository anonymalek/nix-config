{ config, pkgs, ... }:
{
	imports = [
		./pandora-hw.nix
	];

	hostname = "pandora";

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	home-manager.sharedModules = [ ./pandora-home.nix ];

	environment.systemPackages = with pkgs; [
		ryzenadj

		(writeShellScriptBin "settdp" ''
			ryzenadj --stapm-limit=$@000 --slow-limit=$@000 --fast-limit=$@000
		'')
	];

	services.xserver.displayManager.setupCommands = ''
		${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --auto --primary --output eDP-1 --auto --right-of HDMI-1 --mode 1280x800

		# Pandora's touch display
		${pkgs.xorg.xinput}/bin/xinput map-to-output "GXTP7385:00 27C6:0113" "eDP-1"
		${pkgs.xorg.xinput}/bin/xinput disable "GXTP7385:00 27C6:0113"

		# Faulty (not mapped properly) back keys
		${pkgs.xorg.xinput}/bin/xinput disable "keyboard:  Mouse for Windows"
	'';

	services.logind = {
		lidSwitch = "ignore";
	};

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = false;

	hardware.opengl.extraPackages = with pkgs; [
		rocm-opencl-icd
		rocm-opencl-runtime
	];
}
