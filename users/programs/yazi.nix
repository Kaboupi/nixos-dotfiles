{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;

    plugins = {
      glow = pkgs.yaziPlugins.glow;
    };
  };
}
