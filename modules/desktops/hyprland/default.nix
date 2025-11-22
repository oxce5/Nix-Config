{
  unify.modules.hyprland = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        kitty
      ];

      programs = {
        hyprland.enable = true;
      };
    };
    home = {
    };
  };
}
