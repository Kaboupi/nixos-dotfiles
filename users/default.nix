{ pkgs, cfg, ... }:

{
  users.users.${cfg.username} = {
    isNormalUser = true;
    description = cfg.username;
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];
    packages = map (name: pkgs.${name}) cfg.userPackages;

    # NOTE: Add keys after initial setup
    #
    # openssh.authorizedKeys.keys = [
    #
    # ];
  };
}
