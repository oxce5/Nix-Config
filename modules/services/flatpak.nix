{inputs, ...}: {
  unify.modules.workstation = {
    nixos = {pkgs, ...}: {
      imports = [
        inputs.nix-flatpak.nixosModules.nix-flatpak
      ];
      appstream.enable = true;
      environment.systemPackages = with pkgs; [flatpak];
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
        overrides = {
          global = {
            Context.filesystems = ["/nix/store:ro"];
          };
          "gay.elysia.elysia".Context.filesystems = ["/run/current-system/sw/bin:ro"];
        };
      };
    };
  };
}
