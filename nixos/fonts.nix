{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    font-awesome
    # nerdfonts
    jetbrains-mono
    iosevka
    noto-fonts-emoji
    noto-fonts-cjk-sans
  ];
}
