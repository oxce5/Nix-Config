{
  inputs,
  lib,
  withSystem,
  self,
  ...
}: {
  unify.modules.workstation = {
    nixos = {pkgs, ...}: {
      fonts = {
        packages = with pkgs; [
          jetbrains-mono
          montserrat
          libertine
          inter
          openmoji-color
          nerd-fonts.symbols-only
          atkinson-hyperlegible-next
        ];
        enableDefaultPackages = true;
        fontDir.enable = true;
        fontconfig.defaultFonts = {
          sansSerif = ["Atkinson Hyperlegible Next"];
          serif = ["Liberation Serif"];
          monospace = ["JetBrains Mono"];
          emoji = ["OpenMoji Color"];
        };
      };
    };

    home = {
      lib,
      pkgs,
      config,
      system,
      ...
    }: {
      home = {
        pointerCursor = {
          package = self.packages.x86_64-linux.teto-cursor;
          name = "TetoCursor";
          size = 24;
          gtk.enable = true;
          x11.enable = false;
        };

        sessionVariables = {
          XCURSOR_THEME = "TetoCursor";
          XCURSOR_SIZE = 24;
        };
      };
    };
  };
}
