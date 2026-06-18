{ config, pkgs, cfg, ... }:

{
  home.username = cfg.username;
  home.homeDirectory = "/home/${cfg.username}";
  home.stateVersion = cfg.stateVersion;

  programs.bash = {
    enable = true;
    shellAliases = {
      lasts = "last | grep still";
    };
  };

  home.file.".config/hypr".source = ./config/hypr;
}
