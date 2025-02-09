{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    font-awesome
    nerdfonts
    jetbrains-mono
    iosevka
    noto-fonts-color-emoji
  ];
}
