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
    ".config/nvim".source = inputs.lazy-vim;
    ".config/quickshell".source = ./config/quickshell;
  };
}
