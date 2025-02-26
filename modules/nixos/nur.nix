{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nur.repos.ataraxiasjel.waydroid-script
  ];
}
