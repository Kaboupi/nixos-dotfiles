{ pkgs, cfg, ... }:

let
  basePackages = [
    "btop"
    "curl"
    "fd"
    "foot"
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
    "python3"
    "quickshell"
    "ripgrep"
    "rofi"
    "slurp"
    "thunar"
    "tree"
    "tty-clock"
    "unzip"
    "vim"
    "waybar"
    "wget"
    "wl-clipboard"
    "wofi"
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
}
