{ pkgs, cfg, inputs, ... }:

{
  imports = [
    ./programs/caelestia.nix
    ./programs/firefox.nix
    ./programs/hyprland
    ./programs/kitty.nix
    ./programs/rofi.nix
    ./programs/yazi.nix
  ];

  home.username = cfg.username;
  home.homeDirectory = "/home/${cfg.username}";
  home.stateVersion = cfg.stateVersion;
  home.sessionVariables = {
    EDITOR = cfg.defaultEditor;
  };

  home.file = {};

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/gif"  = [ "org.gnome.Loupe.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/png"  = [ "org.gnome.Loupe.desktop" ];
      "image/webp" = [ "org.gnome.Loupe.desktop" ];
    };
  };
}
