{ pkgs, cfg, ... }:

{
  imports = [
    ./hardware.nix

    ../../modules/core/bluetooth.nix
    ../../modules/core/boot.nix
    ../../modules/core/locale.nix
    ../../modules/core/networking.nix
    ../../modules/core/nix.nix
    ../../modules/core/pipewire.nix

    ../../modules/services/docker.nix
    ../../modules/services/openssh.nix
    ../../modules/services/tumbler.nix

    ../../modules/desktop/display-manager.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/packages.nix

    ../../users
  ];

  networking.hostName = cfg.hostname;

  services.greetd = {
    enable = true;
    settings = {
      # NOTE: Handles physical boot
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = cfg.username;
      };
      
      # Fallback definition if you log out of Hyprland manually
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  system.stateVersion = cfg.stateVersion;
}
