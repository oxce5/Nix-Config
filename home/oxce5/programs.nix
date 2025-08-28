{config, lib, ...}: {
  programs = {
    lazygit.enable = true;
    gh.enable = true;
    zen-browser = {
      enable = true;
    };
    firefox.enable = false;
    zellij = {
      enable = false;
      enableZshIntegration = true;
    };
    thefuck.enable = true;
    nh = {
      enable = true;
      clean.enable =
        if config.programs.nh.enable
        then true
        else false;
      clean.extraArgs = "--keep-since 4d --keep 5";
      flake = "/home/oxce5/nix-setup/";
    };
    vscode.enable = lib.mkForce false;
    waybar.enable = lib.mkForce false;
  };
}
