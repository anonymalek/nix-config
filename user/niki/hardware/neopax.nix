{ config, pkgs, ... }:
{
	imports  = [
		./neopax-hw.nix
	];

	hostname = "neopax";

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# passthrough
	boot = {
		kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
		kernelParams = [ "amd_iommu=on" "amd_iommu=pt" "kvm.ignore_msrs=1" "vfio-pci.ids=10de:2504,10de:228e" ];
		extraModprobeConfig = "options vfio-pci ids=10de:2504,10de:228e";
	};

	systemd.tmpfiles.rules = [
		"f /dev/shm/looking-glass 0660 niki qemu-libvirtd -"
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
