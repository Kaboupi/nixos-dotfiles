---@diagnostic disable: undefined-global
---@module 'hl'

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		-- Force the core engine layout
		layout = "dwindle",
		col = {
			active_border = { colors = { "rgba(33ccffff)", "rgba(00ff99ff)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
	},

	dwindle = {
		force_split = 0,
		preserve_split = true,
		smart_split = false,
	},

	decoration = {
		rounding = 10,
		blur = {
			enabled = true,
			size = 5,
			passes = 2,
			noise = 0.0117,
			contrast = 0.9202,
			brightness = 0.8989,
			vibrancy = 0.1696,
			new_optimizations = true,
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
	},

	animations = {
		enabled = true,
	},
})
