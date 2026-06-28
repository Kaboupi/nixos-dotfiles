{ pkgs, cfg, ... }:

{
  programs.mpv = {
    enable = true;

    options = {
      vo = "gpu-next";
      gpu-context = "wayland";  # Wayland >> XWayland
      hwdec = "auto-safe";  # safe hardware decoding

      keep=open = "yes";
      autofit = "50%";
      cursor-autohide = 1000;

      ao = "pipewire";
      volume = 80;
      volume-max = 150;
    };

    bindings = {
      "LEFT" = "seek -5";
      "RIGHT" = "seek 5";
      "UP" = "add volume 2";
      "DOWN" = "add volume -2";
      "SPACE" = "cycle pause";
      "f" = "cycle fullscreen";
    };

    scripts = with pkgs.mpvScripts; [
      mpris
      thumbfast
      uosc
    ];
  }
}
