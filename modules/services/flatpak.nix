{inputs, ...}: {
  unify.modules.workstation = {
    nixos = {
      imports = [
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];
      appstream.enable = true;
    };
    home = {pkgs, ...}: {
      imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
      services.flatpak = {
        enable = true;
        packages = [
          "com.github.tchx84.Flatseal"
          "com.usebottles.bottles"
          "org.vinegarhq.Vinegar"
          "org.vinegarhq.Sober"
          "com.dec05eba.gpu_screen_recorder"
        ];
        uninstallUnmanaged = false;
      };

      # systemd = {
      #   services.flatpak-repo = {
      #     wantedBy = ["multi-user.target"];
      #     path = [pkgs.flatpak];
      #     script = ''
      #       flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      #     '';
      #   };
      # };
    };
  };
}
