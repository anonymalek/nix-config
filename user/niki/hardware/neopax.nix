{ config, pkgs, systemPath, ... }:
{
	imports  = [
		./neopax-hw.nix
		(systemPath + /profiles/core/nvidia.nix)
	];

	hostname = "neopax";

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# passthrough
	# boot = {
	# 	kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
	# 	kernelParams = [ "amd_iommu=on" "amd_iommu=pt" "kvm.ignore_msrs=1" "vfio-pci.ids=10de:2504,10de:228e" ];
	# 	extraModprobeConfig = "options vfio-pci ids=10de:2504,10de:228e";
	# };

	boot.initrd.luks.devices."hdd".device = "/dev/disk/by-uuid/b826b877-19d5-4957-b235-dab1e022b336";

	fileSystems."/home/niki/playground/archive" = {
		device = "/dev/mapper/hdd";
		fsType = "ext4";
		options = [ "nofail" ];
	};

	# systemd.tmpfiles.rules = [
	# 	"f /dev/shm/looking-glass 0660 niki qemu-libvirtd -"
	# ];

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
