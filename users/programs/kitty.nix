{ pkgs, lib, cfg, ... }:

lib.mkIf (cfg.install.kitty or false) {
  programs.kitty = {
    enable = true;

    package = pkgs.kitty;

    settings = lib.mkForce {
      font_family      = "JetBrainsMono Nerd Font";
      bold_font        = "auto";
      italic_font      = "auto";
      bold_italic_font = "auto";
      font_size        = "12.0";

      confirm_os_window_close = "0";
      window_padding_width    = "10";
      hide_window_decorations = "yes";
      background_opacity      = "0.75";

      background = "#1e1e2e";
      foreground = "#cdd6f4";

      # Black
      color0 = "#45475a";
      color8 = "#585b70";

      # Red
      color1 = "#f38ba8";
      color9 = "#f38ba8";

      # Green
      color2  = "#a6e3a1";
      color10 = "#a6e3a1";

      # Yellow
      color3  = "#f9e2af";
      color11 = "#f9e2af";

      # Blue
      color4  = "#89b4fa";
      color12 = "#89b4fa";

      # Magenta
      color5  = "#f5c2e7";
      color13 = "#f5c2e7";

      # Cyan
      color6  = "#89dceb";
      color14 = "#89dceb";

      # White
      color7  = "#bac2de";
      color15 = "#a6adc8";

      linux_display_server = "wayland";
      enable_audio_bell    = "no";
    };
  };
}
