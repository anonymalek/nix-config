args@{ pkgs, userPath, ... }:
{
	imports = [
		(userPath + /shared/shared.nix)
	];

	home.stateVersion = "23.11";

	home.packages = with pkgs; [
		pass
		gnupg
		bottles
		zathura
		mpd
		ncmpcpp
		qemu_full
		sxhkd
		neovim
		emacs
		kitty

    (pkgs.writeShellScriptBin "vmprompt" ''
			cd ~/playground/vm/ && ~/playground/vm/$(ls *.sh | dmenu -i)
		'')

		(pkgs.writeShellScriptBin "tempvm" ''
			qemu-system-x86_64\
				-cdrom ~/playground/common/iso/$(ls ~/playground/common/iso | dmenu -i)\
				-m 6G\
				-smp 4\
				-accel kvm\
				-display sdl\
				-device virtio-vga\
				-monitor none\
				-audiodev pa,id=snd0\
					-device intel-hda\
					-device hda-output,audiodev=snd0 $@
		'')
	];

	home.sessionVariables = {
		BROWSER = "librewolf";
		EDITOR = "nvim";
	};

	services.unclutter = {
		enable = true;
		timeout = 2;
	};

	home.file.".config/libvirt".source = ./libvirt;
	
	programs.home-manager.enable = true;
}
