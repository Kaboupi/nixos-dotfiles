{ cfg, ... }:

{
  programs.bash = {
    enable = false;
    shellAliases = cfg.shellAliases;
  };
}

