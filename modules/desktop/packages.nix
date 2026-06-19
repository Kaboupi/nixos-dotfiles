{ pkgs, cfg, ... }:

{
  environment.systemPackages = map (name: pkgs.${name}) (cfg.basePackages ++ cfg.extraPackages);

  programs.firefox.enable = true;
  programs.thunar.enable = true;
}
