{ inputs, pkgs, cfg, lib, ... }:

let
  mkLuaFile = name: {
    content = ./config + "/${name}.lua";
    autoLoad = true;
  };

  luaModules = [
    "animations"
    "env"
    "exec"
    "general"
    "keybinds"
    "monitors"
    "rules"
  ];
in 
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # NOTE: Bye bye `hyprlang`
    configType = "lua";

    extraLuaFiles = {
      variables = {
        content = ./variables.lua;
        autoLoad = true;
      };
    } // (lib.attrsets.genAttrs luaModules mkLuaFile);
  };
}
