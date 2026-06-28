{ inputs, pkgs, cfg, lib, ... }:

let
  mkLuaFile = name: {
    content = ./config + "/${name}.lua";
    autoLoad = true;
  };

  luaModules = [
    "env"
    "exec"
    "general"
    "keybinds"
    "monitors"
    "windowrules"
    "animations"
  ];
in 
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # NOTE: Bye bye `hyprlang`
    configType = "lua";

    extraLuaFiles = lib.attrsets.genAttrs luaModules mkLuaFile;
  };
}
