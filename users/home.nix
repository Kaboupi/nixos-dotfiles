{ pkgs, cfg, inputs, ... }:

{
  imports = [
    ./programs/caelestia.nix
    ./programs/firefox.nix
    ./programs/yazi.nix
  ];

  home.username = cfg.username;
  home.homeDirectory = "/home/${cfg.username}";
  home.stateVersion = cfg.stateVersion;

  home.file = {
    ".config/hypr".source = ./config/hypr;
    ".config/kitty".source = ./config/kitty;
    ".config/quickshell".source = ./config/quickshell;
    ".config/rofi".source = ./config/rofi;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "image/gif" = [ "org.gnome.Loupe.desktop" ];
      "image/webp" = [ "org.gnome.Loupe.desktop" ];
    };
  };
}
