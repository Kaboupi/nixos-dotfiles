{ pkgs, cfg, ... }:

{
  imports = [
    ./programs/bash.nix
    ./programs/caelestia.nix
    ./programs/firefox.nix
    ./programs/yazi.nix
    ./programs/zsh.nix
  ];

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
