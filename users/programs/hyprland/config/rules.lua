---@diagnostic disable: undefined-global
---@module 'hl'

local vars = require("variables")

hl.window_rule({
	name = "wr-kitty",
	opacity = "0.97 0.85 1.0",
	match = { class = "^(" .. vars.terminal .. ")$" },
})

hl.window_rule({
	name = "wr-yazi-floating",
	float = true,
	center = true,
	size = { 1100, 650 },
	opacity = "0.95 0.75 1.0",
	match = { class = "^(" .. vars.explorer.class .. ")$" },
})

hl.window_rule({
	name = "wr-loupe",
	float = true,
	center = true,
	match = { class = "^(" .. vars.viewers.image .. ")$" },
})

--> ROFI START <--

hl.window_rule({
	name = "wr-rofi",
	float = true,
	center = true,
	opacity = "0.92 0.75",
	match = { class = "^(rofi)$" },
})

hl.layer_rule({
	name = "lr-rofi",
	blur = true,
	match = { class = "^(rofi)$" },
})

--> ROFI END <--

hl.window_rule({
	name = "wr-mpv-fullscreen",
	keep_aspect_ratio = true,
	idle_inhibit = "focus",
	match = { class = "^(" .. vars.viewers.video .. ")$" },
})

hl.window_rule({
	name = "wr-clock",
	float = true,
	center = true,
	size = { 420, 220 },
	match = { class = "^(tty_clock)$" },
})
