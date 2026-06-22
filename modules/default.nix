{ ... }:

{
  imports = [
    # CORE
    ./core/bluetooth.nix
    ./core/boot.nix
    ./core/locale.nix
    ./core/networking.nix
    ./core/nix.nix

    # DESKTOP
    ./desktop/fonts.nix
    ./desktop/hyprland.nix
    ./desktop/packages.nix

    # SERVICES
    ./services/blueman.nix
    ./services/display-manager.nix
    ./services/docker.nix
    ./services/greetd.nix
    ./services/openssh.nix
    ./services/pipewire.nix
    ./services/tumbler.nix
  ];
}
