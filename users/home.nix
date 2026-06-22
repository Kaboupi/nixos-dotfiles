{ pkgs, cfg, inputs, ... }:

{
  home.username = cfg.username;
  home.homeDirectory = "/home/${cfg.username}";
  home.stateVersion = cfg.stateVersion;

  # programs.bash = {
  #   enable = false;
  #   shellAliases = cfg.shellAliases;
  # };

  home.file = {
    ".config/hypr".source = ./config/hypr;
    ".config/kitty".source = ./config/kitty;
    ".config/quickshell".source = ./config/quickshell;
    ".config/rofi".source = ./config/rofi;
    ".config/wofi".source = ./config/wofi;
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
