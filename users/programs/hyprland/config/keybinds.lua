---@diagnostic disable: undefined-global, unused-local
---@module 'hl'

local vars = require("variables")

hl.config({
	input = {
		kb_layout = vars.kbLayout,
		kb_options = vars.kbOptions,
		follow_mouse = 0,
		sensitivity = -1,
		accel_profile = "flat",
		force_no_accel = 1,
	},
})

local mainMod = vars.mainMod

-- General

hl.bind(mainMod .. " + " .. "RETURN", hl.dsp.exec_cmd(vars.terminal), { description = "Open terminal" })
hl.bind(mainMod .. " + " .. "W", hl.dsp.window.close(), { description = "Close active window" })
hl.bind(mainMod .. " + " .. "M", hl.dsp.exit(), { description = "Exit Hyprland" })

-- Apps / commands

hl.bind(mainMod .. " + " .. "B", hl.dsp.exec_cmd(vars.browser), { description = "Open browser" })
hl.bind(
	mainMod .. " + " .. "E",
	hl.dsp.exec_cmd(vars.explorer.floating),
	{ description = "Open file explorer floating" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "E",
	hl.dsp.exec_cmd(vars.explorer.window),
	{ description = "Open file explorer as window" }
)
-- TODO: Add checks: if floating then floating else window or disable
hl.bind(mainMod .. " + " .. "N", hl.dsp.exec_cmd(vars.editor), { description = "Open base editor" })
hl.bind(
	mainMod .. " + " .. "T",
	hl.dsp.exec_cmd(vars.terminal .. " --class tty_clock -e tty-clock"),
	{ description = "Open tty-clock" }
)

-- Caelestia-shell

hl.bind(
	mainMod .. " + " .. "O",
	hl.dsp.exec_cmd(
		"pgrep -f 'quickshell.*caelestia-shell' > /dev/null && caelestia-shell kill || caelestia-shell -n -d"
	),
	{ description = "Toggle caelestia-shell" }
)

-- Rofi

hl.bind(mainMod .. " + " .. "R", hl.dsp.exec_cmd("rofi -show drun"), { description = "Open rofi apps menu" })
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "R",
	hl.dsp.exec_cmd("rofi -show run"),
	{ description = "Open rofi run menu" }
)
hl.bind(mainMod .. " + " .. "Tab", hl.dsp.exec_cmd("rofi -show window"), { description = "Open rofi window menu" })

-- Fullscreen

hl.bind(mainMod .. " + " .. "V", hl.dsp.window.float(), { description = "Float window" })
hl.bind(mainMod .. " + " .. "S", hl.dsp.layout("togglesplit"), { description = "Toggle split active window" })
hl.bind(mainMod .. " + " .. "P", hl.dsp.window.pseudo(), { description = "Toggle pseudo window" })

hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "F",
	hl.dsp.window.fullscreen(),
	{ description = "Toggle window fullscreen" }
)
hl.bind(
	mainMod .. " + " .. "F",
	hl.dsp.window.fullscreen({ mode = "maximized" }),
	{ description = "Toggle window fullscreen [maximized]" }
)

-- Arrows

hl.bind(mainMod .. " + " .. "left", hl.dsp.focus({ direction = "left" }), { description = "Move window focus left" })
hl.bind(mainMod .. " + " .. "right", hl.dsp.focus({ direction = "right" }), { description = "Move window focus right" })
hl.bind(mainMod .. " + " .. "up", hl.dsp.focus({ direction = "up" }), { description = "Move window focus up" })
hl.bind(mainMod .. " + " .. "down", hl.dsp.focus({ direction = "down" }), { description = "Move window focus down" })
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "left",
	hl.dsp.window.swap({ direction = "left" }),
	{ description = "Move window left" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "right",
	hl.dsp.window.swap({ direction = "right" }),
	{ description = "Move window right" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "up",
	hl.dsp.window.swap({ direction = "up" }),
	{ description = "Move window up" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "down",
	hl.dsp.window.swap({ direction = "down" }),
	{ description = "Move window down" }
)

-- Vim keys

hl.bind(mainMod .. " + " .. "H", hl.dsp.focus({ direction = "left" }), { description = "Move window focus left" })
hl.bind(mainMod .. " + " .. "L", hl.dsp.focus({ direction = "right" }), { description = "Move window focus right" })
hl.bind(mainMod .. " + " .. "K", hl.dsp.focus({ direction = "up" }), { description = "Move window focus up" })
hl.bind(mainMod .. " + " .. "J", hl.dsp.focus({ direction = "down" }), { description = "Move window focus down" })
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "H",
	hl.dsp.window.swap({ direction = "left" }),
	{ description = "Move window left" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "L",
	hl.dsp.window.swap({ direction = "right" }),
	{ description = "Move window right" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "K",
	hl.dsp.window.swap({ direction = "up" }),
	{ description = "Move window up" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. "J",
	hl.dsp.window.swap({ direction = "down" }),
	{ description = "Move window down" }
)

-- Workspaces

hl.bind(mainMod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }), { description = "Switch to workspace 1" })
hl.bind(mainMod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }), { description = "Switch to workspace 2" })
hl.bind(mainMod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }), { description = "Switch to workspace 3" })
hl.bind(mainMod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }), { description = "Switch to workspace 4" })
hl.bind(mainMod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }), { description = "Switch to workspace 5" })
hl.bind(mainMod .. " + " .. 6, hl.dsp.focus({ workspace = 6 }), { description = "Switch to workspace 6" })
hl.bind(mainMod .. " + " .. 7, hl.dsp.focus({ workspace = 7 }), { description = "Switch to workspace 7" })

-- Move to workspace

hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. 1,
	hl.dsp.window.move({ workspace = 1 }),
	{ description = "Move active window to workspace 1" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. 2,
	hl.dsp.window.move({ workspace = 2 }),
	{ description = "Move active window to workspace 2" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. 3,
	hl.dsp.window.move({ workspace = 3 }),
	{ description = "Move active window to workspace 3" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. 4,
	hl.dsp.window.move({ workspace = 4 }),
	{ description = "Move active window to workspace 4" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. 5,
	hl.dsp.window.move({ workspace = 5 }),
	{ description = "Move active window to workspace 5" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. 6,
	hl.dsp.window.move({ workspace = 6 }),
	{ description = "Move active window to workspace 6" }
)
hl.bind(
	mainMod .. " + " .. "SHIFT" .. " + " .. 7,
	hl.dsp.window.move({ workspace = 7 }),
	{ description = "Move active window to workspace 7" }
)

-- Mouse binds

hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- WirePlumber / wpctl

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { description = "Mute audio" })
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ description = "Volume down" }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ description = "Volume up" }
)

-- Screenshots

hl.bind(
	"Print",
	hl.dsp.exec_cmd("grim -g $(slurp)-| wl-copy"),
	{ description = "Take a screenshot and copy to clipboard" }
)
hl.bind(
	mainMod .. " + " .. "Print",
	hl.dsp.exec_cmd("grim ~/Pictures/$(date +'%Y%m%d_%H%M%S_screenshot.png')"),
	{ description = "Take a screenshot and paste to default Picture dir" }
)
