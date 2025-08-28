{
  inputs,
  outputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
    inputs.zen-browser.homeModules.twilight
    inputs.impermanence.homeManagerModules.impermanence
    outputs.nixosModules.mutable

    ../../machines/dots
    ./packages.nix
    ./programs.nix
    ./wm
  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    extraConfig = {
      credential.helper = "store";
    };
    userName  = "oxce5";
    userEmail = "avg.gamer@proton.me";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };



  # home-manager options go here/

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/roblox-player" = "org.vinegarhq.Sober.desktop";
    };
  };

  home.persistence."/persistent" = {
    directories = [
      ".zen"
    ];
    allowOther = false;
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  services.clipse.enable = true;
}
