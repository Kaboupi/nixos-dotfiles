# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./virtualbox.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.fsIdentifier = "provided";

  networking.hostName = "kaboupi-nixos";
  # Enables wireless support via wpa_supplicant.
  networking.wireless.enable = true;  

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."kaboupi" = {
    isNormalUser = true;
    description = "kaboupi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    curl
    git
    github-cli
    kitty
    vim
    wget
    wofi
  ];

  # Vim
# TODO: Add .vimrc via nix not bash
#  programs.vim = {
#    enable = true;
#    defaultEditor = true;
#
#    extraConfig = builtins.readFile (pkgs.fetchurl {
#      url = "https://raw.githubusercontent.com/Kaboupi/vm-essentials/main/dotfiles/.vimrc";
#      sha256 = "sha256-Am8Qnxy9DQ/nNRcsuEuIQTM/OLC3l6z1XBhsSsnRgfI";
#    });
#  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  hardware = {
    graphics.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # TODO: Enable frw w/ ufw
  networking.firewall.enable = false;

  # !!! Do not change !!!
  system.stateVersion = "26.05"; 

  # Post-init-like scripts
  system.activationScripts.downloadVimrc = {
    text = ''
      USER_HOME="/home/kaboupi"
      if [ -d "$USER_HOME" ]; then

        echo "=== Get .vimrc from repo ==="

        DOWNLOADED_FILE=${pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/Kaboupi/vm-essentials/main/dotfiles/.vimrc";
          sha256 = "sha256-Am8Qnxy9DQ/nNRcsuEuIQTM/OLC3l6z1XBhsSsnRgfI";
        }}

        echo "=== Setup .vimrc for root ==="
        cp -f "$DOWNLOADED_FILE" "/root/.vimrc"
        chown root:root "/root/.vimrc"
        chmod 644 "/root/.vimrc"

        echo "=== Setup .vimrc for user ==="
        cp -f "$DOWNLOADED_FILE" "$USER_HOME/.vimrc"
        chown kaboupi:users "$USER_HOME/.vimrc"
        chmod 644 "$USER_HOME/.vimrc"
      fi
    '';
  };
}
