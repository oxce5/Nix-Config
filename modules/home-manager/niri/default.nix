{inputs, outputs, pkgs, ...}:

let 
  swww = inputs.swww.packages.${pkgs.system}.swww;
in {
  imports = [
    ./niri-inputs.nix
    ./niri-layouts.nix
    ./niri-env.nix
    ./niri-binds.nix
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    alacritty
    mako
    swww
  ];

  services = {
    swayidle = {
      enable = true;
    };
  };

  programs.niri = {
    settings = {
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;

      outputs."eDP-1" = { 
        mode = {
          width = 1920;
          height = 1080;
          refresh = 144;
        };
        scale = 1.0; 
        position.x = 0;
        position.y = 0;
      };

      overview.workspace-shadow.enable = false;
      spawn-at-startup = [
        { command = [ "kurukurubar" ]; }
        { command = [ "swww-daemon" ]; }
        { command = [ "swww-daemon" "-n" "backdrop"]; }
        { command = [ "swww" "img" "~/nix-setup/home/oxce5/tetoes4.jpg" ]; }
        { command = ["swww" "img" "-n" "backdrop" "~/nix-setup/home/oxce5/tetoes4_blur.jpg"]; }
        { command = ["xwayland-satellite"]; }
      ];
    }; 
  };
}
