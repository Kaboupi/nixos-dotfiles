{ cfg, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "extract"
      ];
      theme = "refined";
    };

    shellAliases = cfg.shellAliases;
  };
}
