return {
	mainMod = "SUPER",

	terminal = "kitty",
	browser = "firefox",
	editor = "kitty -e nvim",

	viewers = {
		image = "loupe",
		video = "mpv",
	},

	explorer = {
		window = "kitty -e yazi",
		class = "yazi_floating",
		floating = "kitty --class yazi_floating -e yazi",
	},

	audiosettings = "pavucontrol",

	kbLayout = "us,ru",
	kbOptions = "grp:win_space_toggle",
}
