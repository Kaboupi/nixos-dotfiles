{ cfg, ... }:

{
  imports = [
    ./hardware.nix

    ../../modules/core/boot.nix
    ../../modules/core/locale.nix
    ../../modules/core/networking.nix
    ../../modules/core/nix.nix

    ../../modules/services/openssh.nix
    ../../modules/services/docker.nix

    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/display-manager.nix
    ../../modules/desktop/packages.nix

    ../../users
  ];

  networking.hostName = cfg.hostname;

  services.getty.autologinUser = cfg.username;

  system.stateVersion = cfg.stateVersion;
}
