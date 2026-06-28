---@diagnostic disable: undefined-global
---@module 'hl'

hl.window_rule({
	name = "wr-kitty",
	match = {
		class = "^(kitty)$",
	},
	opacity = "0.97 0.85 1.0",
})

hl.window_rule({
	name = "wr-yazi-floating",
	match = {
		class = "^(yazi_floating)$",
	},
	float = true,
	size = { 1100, 650 },
	center = true,
	opacity = "0.95 0.75 1.0",
})

hl.window_rule({
	name = "wr-loupe",
	match = {
		class = "^(loupe)$",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "wr-mpv-fullscreen",
	match = {
		class = "^(mpv)$",
	},
	keep_aspect_ratio = true,
	idle_inhibit = "focus",
})

hl.window_rule({
	name = "wr-clock",
	match = {
		class = "^(tty_clock)$",
	},
	float = true,
	size = { 420, 220 },
	center = true,
})
