{ pkgs, cfg, ... }:

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
      theme = "robbyrussell";
    };

    shellAliases = cfg.shellAliases;
  };

  users.users.${cfg.username} = {
    isNormalUser = true;
    description = cfg.username;
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];

    packages = map (name: pkgs.${name}) cfg.userPackages;

    shell = pkgs.zsh;

    # NOTE: Add keys after initial setup
    #
    # openssh.authorizedKeys.keys = [
    #
    # ];
  };
}
