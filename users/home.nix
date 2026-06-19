{ pkgs, cfg, inputs, ... }:

{
  home.username = cfg.username;
  home.homeDirectory = "/home/${cfg.username}";
  home.stateVersion = cfg.stateVersion;

  programs.bash = {
    enable = true;
    shellAliases = cfg.shellAliases;
  };

  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/nvim".source = inputs.lazy-vim;
}
