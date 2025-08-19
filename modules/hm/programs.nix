{config, lib, ...}: {
  programs = {
    lazygit.enable = true;
    gh.enable = true;
    zen-browser = {
      enable = true;
    };
    zellij = {
      enable = false;
      enableZshIntegration = true;
    };
    nh = {
      enable = true;
      clean.enable =
        if config.programs.nh.enable
        then true
        else false;
      clean.extraArgs = "--keep-since 4d --keep 5";
      flake = "/home/oxce5/omanix/";
    };
    waybar.enable = lib.mkForce false;
  };
  
}
