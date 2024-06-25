{ pkgs, ... }:
{
	packages = with pkgs; [
		quickemu
		virt-manager
		weston
	];

	groups = [ "libvirtd" ];

	sys = { nixpkgs-unstable, ... }: {
		virtualisation.libvirtd = {
			enable = true;
			qemu = {
				package = pkgs.qemu_kvm;
				runAsRoot = true;
				swtpm.enable = true;
				ovmf = {
					enable = true;
					packages = [(nixpkgs-unstable.legacyPackages.x86_64-linux.OVMF.override {
						secureBoot = true;
						tpmSupport = true;
					}).fd];
				};
			};
		};

		virtualisation.waydroid.enable = true;
	};
}
