{inputs, ...}: {
  unify.modules.anime = {
    nixos = {
      networking.firewall.allowedTCPPorts = [43211];
    };
    home = {pkgs, ...}: {
      imports = [inputs.seanime.nixosModules.seanime];

      modules.home.services.seanime.enable = true;

      home.packages = with pkgs; [
        mpv
        ffmpeg-full
      ];
    };
  };
}
