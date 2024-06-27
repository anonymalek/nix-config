{ config, lib, pkgs, systemPath, ... }:
let
	law = import (systemPath + /law.nix) {
		inherit pkgs lib systemPath;
	};
in
{
	imports  = [
		./termina-hw.nix
		(law.makeSystemModule [/core/nvidia])
	];

	# tf2cfgPath = "/mnt/Game/SteamLibrary/steamapps/common/Team Fortress 2/tf/cfg/";

	hostname = "termina";

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	services.xserver.xkb.layout = "br";

	# passthrough
	boot = {
		kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
		kernelParams = [ "amd_iommu=on" "amd_iommu=pt" "kvm.ignore_msrs=1" "vfio-pci.ids=10de:2504,10de:228e" ];
		extraModprobeConfig = "options vfio-pci ids=10de:2504,10de:228e";
	};
	
	fileSystems."/mnt/Game" = { 
		device = "/dev/disk/by-uuid/67b50152-cd96-48b5-a78d-84d1992b82f4";
		fsType = "xfs";
		
		options = [
			"rw"
			"user"
			"exec"
			"nofail"
			"defaults"
		];
	};
	
	fileSystems."/mnt/Docs" = { 
		device = "/dev/disk/by-uuid/e74c2833-c605-403a-8572-8a1527de8a77";
		fsType = "ext4";
		
		options = [
			"rw"
			"user"
			"exec"
			"nofail"
			"defaults"
		];
	};
	   
	systemd.tmpfiles.rules = [
		"d /mnt 0755 root root -"
		"d /mnt/Game 0755 1000:100 alek -"
		"d /mnt/Docs 0755 1000:100 alek -"
		"f /dev/shm/looking-glass 0660 alek qemu-libvirtd -"
	];

	environment.systemPackages = with pkgs; [
		looking-glass-client
		libxfs
	];

	services.openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = false;
		};
	};

	hardware.bluetooth = {
		enable = true;
		powerOnBoot = false;
		package = pkgs.bluez;
	};
}
