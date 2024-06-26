{ pkgs, ... }:
{
	programs.tmux = {
		enable = true;
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
}
