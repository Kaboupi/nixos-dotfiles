---@diagnostic disable: undefined-global
---@module 'hl'

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	-- TODO: Assign a variable to '/etc/nixos' abs path
	-- from `config.nix` -> installationDir
	hl.exec_cmd("hyprpaper --config /etc/nixos/users/programs/hyprland/tools/hyprpaper.conf")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("caelestia-shell -n -d")
end)
