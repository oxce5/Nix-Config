{
  unify.modules.workstation.nixos = {
    inputs,
    pkgs,
    ...
  }: {
    appstream.enable = true;
    services.flatpak = {
      enable = false;
      packages = [
        "com.github.tchx84.Flatseal"
        "com.usebottles.bottles"
        "io.mrarm.mcpelauncher"
        "org.vinegarhq.Vinegar"
        "org.vinegarhq.Sober"
        "com.dec05eba.gpu_screen_recorder"
      ];
    };

    systemd = {
      services.flatpak-repo = {
        wantedBy = ["multi-user.target"];
        path = [pkgs.flatpak];
        script = ''
          flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
      };
    };
  };
}
