{ config, pkgs, ... }:

{
  virtualisation.virtualbox.guest.enable = true;

  environment.sessionVariables = {
    WRL_NO_HARDWARE_CURSORS = "1";
    WRL_RENDERER_ALLOW_SOFTWARE = "1";
    WRL_BACKENDS = "pixman";

    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

  services.dbus.enable = true;
}
