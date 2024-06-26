{ ... }:
{
	programs.kitty = {
		enable = true;

		font = {
			name = "Terminus (TTF)";
			size = 14;
		};

		settings = {
			open_url_with = "echo";
			cursor_shape = "block";
			url_style = "dashed";
			enable_audio_bell = false;
		};

		keybindings = {
			"kitty_mod+t" = "launch --type=tab --cwd=current";
		};
	};
}
