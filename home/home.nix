{ config, pkgs, ... }:

{
  home.username = "kaboupi";
	home.homeDirectory = "/home/kaboupi";
	home.stateVersion = "26.05";
	programs.bash = {
    enable = true;
    shellAliases = {
      lasts = "last | grep still";
    };
  };

  home.file.".config/hypr".source = ./config/hypr;
}
