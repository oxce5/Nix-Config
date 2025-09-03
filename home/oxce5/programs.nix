{
  config,
  lib,
  ...
}: {
  programs = {
    lazygit.enable = true;
    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
    zen-browser = {
      enable = true;
    };
    firefox.enable = false;
    zellij = {
      enable = false;
      enableZshIntegration = true;
    };
    pay-respects.enable = true;
    nh = {
      enable = true;
      clean.enable =
        if config.programs.nh.enable
        then true
        else false;
      clean.extraArgs = "--keep-since 4d --keep 5";
      flake = "/home/oxce5/nix-setup/";
    };
    git = {
      enable = true;
      extraConfig = {
        credential.helper = "store";
      };
      userName = "oxce5";
      userEmail = "avg.gamer@proton.me";
    };
    vscode.enable = lib.mkForce false;
    waybar.enable = lib.mkForce false;
  };
}
