{ pkgs, ... }:

let
	terminal = "kitty --directory ~/";
	browser = "librewolf";
	browser_new_window = "librewolf --new-window";

	dmenu_selector = "dmenu";

	shbinpkgs = rec {
		vmprompt = (pkgs.writeShellScriptBin "vmprompt" ''
			cd ~/playground/vm/ && ~/playground/vm/$(ls *.sh | ${dmenu_selector} -i)
		'');

		tempvm = (pkgs.writeShellScriptBin "tempvm" ''
			qemu-system-x86_64\
				-cdrom ~/playground/common/iso/$(ls ~/playground/common/iso | ${dmenu_selector} -i)\
				-m 6G\
				-smp 4\
				-accel kvm\
				-display sdl\
				-device virtio-vga\
				-audiodev pa,id=snd0\
					-device intel-hda\
					-device hda-output,audiodev=snd0 $@
		'');

		recordtty = (pkgs.writeShellScriptBin "recordtty" ''
			script -t="$1.timing" -q "$1.log"
		'');

		replaytty = (pkgs.writeShellScriptBin "replaytty" ''
			scriptreplay -t "$1.timing" "$1.log"
		'');

		gitsshswap = (pkgs.writeShellScriptBin "gitsshswap" ''
			sed -i "s/git@.*:/git@$1:/g" .git/config
		'');

		edhost = (pkgs.writeShellScriptBin "edhost" ''
			if [ $(id -u) -ne 0 ]; then
				echo "You must be root."
				exit 2
			fi

			# un-symlink
			rm /etc/hosts && cp /etc/static/hosts /etc/hosts

			for name in ''${@:2}; do
				echo hostess add $name $1
				${pkgs.hostess}/bin/hostess add $name $1
			done
		'');

		edhl = (pkgs.writeShellScriptBin "edhl" ''
			sudo ${edhost}/bin/edhost 192.168.0.$1 ''${@:2}
		'');

		setm = (pkgs.writeShellScriptBin "setm" ''
			sudo ${edhost}/bin/edhost $1 master ''${@:2}
		'');

		setml = (pkgs.writeShellScriptBin "setml" ''
			sudo ${setm}/bin/setm 192.168.0.$1 $2
		'');
	};
in
{
	home.stateVersion = "23.11";

	home.packages = with pkgs; [
		shbinpkgs.vmprompt
		shbinpkgs.tempvm
		shbinpkgs.recordtty
		shbinpkgs.replaytty

		shbinpkgs.gitsshswap

		shbinpkgs.edhost
		shbinpkgs.edhl
		shbinpkgs.setm
		shbinpkgs.setml

		neovim
		mpc-cli
	];

	home.file = let
		tf2Root = ".firejail_steam/.local/share/Steam/steamapps/common/Team Fortress 2/tf/cfg";
	in {
		".config/awesome/".source = ./sources/awesome;
		".vimrc".source = ./sources/vim/vimrc;
		".config/nvim".source = ./sources/vim;
		".config/kitty".source = ./sources/kitty;
		".local/share/fonts".source = ./sources/fonts;
		".config/libvirt".source = ./sources/libvirt;
		".firejail_qutebrowser/.config/qutebrowser/config.py".source = ./sources/qutebrowser/config.py;

		"${tf2Root}/autoexec.cfg".source = ./sources/tf2/autoexec.cfg;
		"${tf2Root}/binds.cfg".source = ./sources/tf2/binds.cfg;
		"${tf2Root}/defaultbinds.cfg".source = ./sources/tf2/defaultbinds.cfg;
		"${tf2Root}/engineer.cfg".source = ./sources/tf2/engineer.cfg;
		"${tf2Root}/gfx.cfg".source = ./sources/tf2/gfx.cfg;
		"${tf2Root}/network.cfg".source = ./sources/tf2/network.cfg;
		"${tf2Root}/settings.cfg".source = ./sources/tf2/settings.cfg;
	};

	home.sessionVariables = {
		BROWSER = "librewolf";
		EDITOR = "nvim";
	};

	programs.tmux = {
		# enable = true;
		clock24 = true;
		
		keyMode = "vi";

		plugins = with pkgs.tmuxPlugins; [
			vim-tmux-navigator
			yank
		];

		extraConfig = ''
			set-option -sa terminal-overrides ",xterm*:Tc"
			
			set -g base-index 1
			set -g pane-base-index 1
			set-window-option -g pane-base-index 1
			set-option -g renumber-windows on

			bind-key -T copy-mode-vi v send-keys -X begin-selection
			bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
			bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

			bind -n M-H previous-window
			bind -n M-L next-window

			bind '"' split-window -v -c "#{pane_current_path}"
			bind % split-window -h -c "#{pane_current_path}"
			bind c new-window -c "#{pane_current_path}"

			set -g status-bg black
			set -g status-fg white
			
			bind-key S choose-window "join-pane -v -s "%%""
			bind-key V choose-window "join-pane -h -s "%%""

			set-option -g prefix C-a
		'';
	};

	programs.zathura.enable = true;

	programs.rofi = {
		enable = true;
		font = pkgs.lib.mkDefault "Terminus (TTF) 14";
		terminal = "${pkgs.kitty}/bin/kitty";
		theme = pkgs.lib.mkDefault "Arc-Dark";

		plugins = with pkgs; [
			rofi-calc
		];

		extraConfig = {
			modi = "run,drun";
		};
	};

	xsession.enable = true;

	services.unclutter = {
		enable = true;
		timeout = 2;
	};

	services.mpd = {
		enable = true;
		musicDirectory = "~/playground/music";	
	};

	programs.ncmpcpp = {
		enable = true;
		mpdMusicDir = "~/playground/music";
	};

	programs.bash = {
		enable = true;
		shellAliases = {
			"ll" = "ls -l";
			"la" = "ls -la";
			".." = "cd ..";

			"nxs" = "nix search nixpkgs";

			"poweroff" = "systemctl poweroff -i";
			"shutdown" = "systemctl poweroff -i";
			"reboot" = "systemctl reboot -i";

			"proxychains" = "proxychains4";

			"p" = "cd ~/playground";
			"c" = "cd ~/playground/configuration && ls -l";
		};

		historyFileSize = 0;
	};

	services.sxhkd = {
		enable = true;

		keybindings = {
			"super + d" = "${browser_new_window} https://discord.com/app";
			"super + q" = "${browser}";
			"super + ctrl + q" = "qutebrowser";
			"super + a" = terminal + " pulsemixer";
			"super + Return" = "${terminal}";
			# "super + shift + Return" = "${terminal} tmux";
			# "super + ctrl + Return" = "${terminal} tmux attach";

			"super + v" = "tempvm";
			"super + shift + v" = "vmprompt";

			"super + e" = ''pass -c $(find .password-store/ -iname "*.gpg" | sed -e "s/\.password-store\///g" -e "s/\.gpg//g" | sort | ${dmenu_selector})'';
			"super + shift + m" = terminal + " ncmpcpp";
			"super + shift + s" = "flameshot gui";

			# slock
			"super + alt + 1" = "slock -m 'shutting down in 1 minute' -t 60 -c 'systemctl poweroff -i'";
			"super + alt + 2" = "slock -m 'shutting down in 5 minutes' -t ${toString (60 * 5)} -c 'systemctl poweroff -i'";
			"super + alt + 3" = "slock -m 'shutting down in 15 minutes' -t ${toString (60 * 15)} -c 'systemctl poweroff -i'";
			"super + alt + 4" = "slock -m 'shutting down in 30 minutes' -t ${toString (60 * 30)} -c 'systemctl poweroff -i'";
			"super + alt + 5" = "slock -m 'shutting down in 1 hour' -t ${toString (60 * 60 * 1)} -c 'systemctl poweroff -i'";
			"super + alt + 6" = "slock -m 'shutting down in 1 hour and 30 minutes' -t ${toString (60 * 30 * 3)} -c 'systemctl poweroff -i'";
			"super + alt + 7" = "slock -m 'shutting down in 3 hours' -t ${toString (60 * 60 * 3)} -c 'systemctl poweroff -i'";
			"super + alt + 8" = "slock -m 'shutting down in 6 hours' -t ${toString (60 * 60 * 6)} -c 'systemctl poweroff -i'";
			"super + alt + 9" = "slock -m 'shutting down in 12 hours' -t ${toString (60 * 60 * 12)} -c 'systemctl poweroff -i'";
			"super + alt + 0" = "slock -m 'shutting down in 24 hours' -t ${toString (60 * 60 * 24)} -c 'systemctl poweroff -i'";

			"super + alt + s" = "slock & sleep 0.5 && systemctl suspend";

			"super + alt + d" = "slock";

			"super + alt + f" = "slock -i -t ${toString (60 * 60 * 24)} -c 'systemctl poweroff -i'";

			"XF86MonBrightnessUp" = "brightnessctl s +10%";
			"XF86MonBrightnessDown" = "brightnessctl s 10%-";

			"XF86AudioRaiseVolume" = "pulsemixer --change-volume +5";
			"XF86AudioLowerVolume" = "pulsemixer --change-volume -5";
			"XF86AudioMute" = "pulsemixer --toggle-mute";

			"XF86AudioPlay" = "mpc toggle";
			"XF86AudioStop" = "mpc stop";

			"XF86AudioPrev" = "mpc next";
			"XF86AudioNext" = "mpc prev";

			"super + i" = "mpc prev";
			"super + o" = "mpc toggle";
			"super + p" = "mpc next";

			"super + w" = "surf localhost:8384";
		};
	};

	programs.home-manager.enable = true;
}
