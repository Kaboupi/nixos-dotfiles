{ pkgs, cfg, inputs, ... }:

{
  imports = [
    ./programs/caelestia.nix
    ./programs/firefox.nix
    ./programs/kitty.nix
    ./programs/yazi.nix
  ];

  home.username = cfg.username;
  home.homeDirectory = "/home/${cfg.username}";
  home.stateVersion = cfg.stateVersion;
  home.sessionVariables = {
    EDITOR = cfg.defaultEditor;
  };

  home.file = {
    ".config/hypr".source = ./config/hypr;
    ".config/rofi".source = ./config/rofi;
  };

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
