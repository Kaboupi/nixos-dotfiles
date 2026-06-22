{ pkgs, cfg, ... }:

let
  basePackages = [
    "btop"
    "curl"
    "fd"
    "ffmpegthumbnailer"
    "fontforge"
    "foot"
    "fzf"
    "gcc"
    "git"
    "github-cli"
    "gnumake"
    "grim"
    "hyprlock"
    "hyprpaper"
    "kitty"
    "lazygit"
    "loupe"
    "neovim"
    "nodejs"
    "pavucontrol"
    "poppler"
    "pulsemixer"
    "python3"
    "quickshell"
    "ripgrep"
    "rofi"
    "slurp"
    "tree"
    "tty-clock"
    "unzip"
    "vim"
    "wget"
    "wl-clipboard"
    "yazi"
  ];
in
{
  environment.systemPackages = map (name: pkgs.${name}) (basePackages ++ cfg.extraPackages);

  programs.firefox.enable = true;
  programs.thunar.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
  ];

  programs.yazi = {
    enable = true;

    plugins = {
      glow = pkgs.yaziPlugins.glow;
      # exiftool = pkgs.yaziPlugins.exiftool;
    };
  };
}
