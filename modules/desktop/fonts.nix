{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    jetbrains-mono
    
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome  # NOTE: Essential for many Waybar icon setups
  ];
}
