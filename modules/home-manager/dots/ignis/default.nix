{pkgs, inputs, ...}:

{
  imports = [inputs.ignis.homeManagerModules.default];

  programs.ignis = {
    enable = true;
    package = inputs.ignis.packages.${pkgs.system}.default;

    configDir = ./ignis;
    services = {
      bluetooth.enable = true;
      recorder.enable = true;
      audio.enable = true;
      network.enable = true;
    };

    # Enable Sass support
    sass = {
      enable = true;
      useDartSass = true;
    };

    # Extra packages available at runtime
    # These can be regular packages or Python packages
    extraPackages = with pkgs; [
      matugen
      gnome-bluetooth
      adw-gtk3
    ];
  };
}
