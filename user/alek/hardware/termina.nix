{ config, pkgs, ... }:
{
	imports  = [
		./../../../system/profiles/core/nvidia.nix
		./termina-hw.nix
	];

	hostname = "termina";

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# passthrough
	boot = {
		kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
		kernelParams = [ "amd_iommu=on" "amd_iommu=pt" "kvm.ignore_msrs=1" "vfio-pci.ids=10de:2504,10de:228e" ];
		extraModprobeConfig = "options vfio-pci ids=10de:2504,10de:228e";
	};
	
	boot.supportedFilesystems = [ "ntfs" ];
	
	fileSystems."/mnt/Game" = {
	   device = "/dev/disk/by-uuid/2fcb18b3-6f0e-9b4e-b83a-8d727de44819";
	   fsType = "ntfs-3g"; 
	   options = [ # If you don't have this options attribute, it'll default to "defaults" 
		 # boot options for fstab. Search up fstab mount options you can use
		 "users" # Allows any user to mount and unmount
		 "nofail" # Prevent system from failing if this drive doesn't mount
		 "rw" "uid=1000"
	   ];
	};

	systemd.tmpfiles.rules = [
		"f /dev/shm/looking-glass 0660 alek qemu-libvirtd -"
		
		"d /mnt 0755 root root -"
		"d /mnt/Game 0755 alek alek -"
	];

	environment.systemPackages = with pkgs; [
		looking-glass-client
	];

	services.openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = false;
		};
	};

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = false;
}