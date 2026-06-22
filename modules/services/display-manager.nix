{ ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.displayManager = {
    sddm.enable = true;
    defaultSession = "hyprland";
  };
}
