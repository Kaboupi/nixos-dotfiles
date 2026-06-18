{ config, pkgs, cfg, ... }: {

  time.timeZone = cfg.timezone;

  i18n.defaultLocale = cfg.locale;

  networking.networkmanager.enable = true;
  networking.wireless.enable = true;
  networking.firewall.enable = false;

  services.openssh.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.firefox.enable = true;

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.displayManager = {
    sddm.enable = true;
    defaultSession = "hyprland";
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
