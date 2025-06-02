
{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
