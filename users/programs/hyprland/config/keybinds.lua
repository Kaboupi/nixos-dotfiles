---@diagnostic disable: undefined-global
---@module 'hl'

hl.config({
	input = {
		kb_layout = "us,ru",
		kb_options = "grp:win_space_toggle",
		follow_mouse = 0,
		sensitivity = -1,
		accel_profile = "flat",
		force_no_accel = 1,
	},
})

local mainMod = "SUPER"

-- General

hl.bind(mainMod .. " + " .. "RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + " .. "W", hl.dsp.window.close())
hl.bind(mainMod .. " + " .. "M", hl.dsp.exit())

-- Apps / commands

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "E", hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind(mainMod .. " + " .. "B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd("kitty --class yazi_floating -e yazi"))
hl.bind(mainMod .. " + " .. "N", hl.dsp.exec_cmd("kitty -e nvim"))
hl.bind(mainMod .. " + " .. "T", hl.dsp.exec_cmd("kitty --class tty_clock -e tty-clock"))
hl.bind(mainMod .. " + " .. "P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + " .. "S", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + " .. "V", hl.dsp.window.float())

-- Caelestia-shell

hl.bind(
	mainMod .. " + " .. "O",
	hl.dsp.exec_cmd(
		"pgrep -f 'quickshell.*caelestia-shell' > /dev/null && caelestia-shell kill || caelestia-shell -n -d"
	)
)

-- Rofi

hl.bind(mainMod .. " + " .. "R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "R", hl.dsp.exec_cmd("rofi -show run"))
hl.bind(mainMod .. " + " .. "Tab", hl.dsp.exec_cmd("rofi -show window"))

-- Fullscreen

hl.bind(mainMod .. " + " .. "F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "F", hl.dsp.window.fullscreen())

-- Arrows

hl.bind(mainMod .. " + " .. "left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. "up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. "down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "down", hl.dsp.window.swap({ direction = "down" }))

-- Vim keys

hl.bind(mainMod .. " + " .. "H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. "L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. "K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. "J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "J", hl.dsp.window.swap({ direction = "down" }))

-- Workspaces

hl.bind(mainMod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + " .. 6, hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + " .. 7, hl.dsp.focus({ workspace = 7 }))

-- Move to workspace

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 6, hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 7, hl.dsp.window.move({ workspace = 7 }))

-- Mouse binds

hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- WirePlumber / wpctl

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"))

-- Screenshots

hl.bind("Print", hl.dsp.exec_cmd("grim -g $(slurp)-| wl-copy"))
hl.bind(mainMod .. " + " .. "Print", hl.dsp.exec_cmd("grim ~/Pictures/$(date +'%Y%m%d_%H%M%S_screenshot.png')"))
