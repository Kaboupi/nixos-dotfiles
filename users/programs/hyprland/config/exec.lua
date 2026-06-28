---@diagnostic disable: undefined-global
---@module 'hl'

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("caelestia-shell")
end)
