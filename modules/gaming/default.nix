{inputs, ...}: {
  unify.modules.gaming = {
    nixos = {
      pkgs,
      hostConfig,
      ...
    }: {
      imports = [
        inputs.nix-gaming.nixosModules.platformOptimizations
      ];
      boot.kernelModules = ["ntsync"];
      environment.systemPackages = with pkgs; [
        # Launchers
        heroic
        lutris
        prismlauncher

        # Utility
        goverlay
        mangohud
        protontricks
        protonplus
        winetricks
        ludusavi

        # Recording
        gpu-screen-recorder
        gpu-screen-recorder-gtk

        lsfg-vk
        lsfg-vk-ui
      ];
      # Allows gpu-screen-recorder to record screens without escalating
      hardware = {
        graphics.enable32Bit = true;
      };
      programs = {
        steam = {
          enable = true;
          platformOptimizations.enable = true;
          remotePlay.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          extraCompatPackages = with pkgs; [
            proton-cachyos
            steamtinkerlaunch
          ];
        };
        gamescope = {
          enable = true;
          args = [
            "-W ${toString hostConfig.primaryDisplay.width}"
            "-H ${toString hostConfig.primaryDisplay.height}"
            "-r ${toString hostConfig.primaryDisplay.refreshRate}"
            "-O ${hostConfig.primaryDisplay.name}"
            "-f"
            "--adaptive-sync"
            "--mangoapp"
          ];
        };
      };
    };
    home = {
      programs.obs-studio = {
        enable = true;
      };
    };
  };
}
