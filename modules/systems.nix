{
  den,
  __findFile,
  ...
}: {
  chimera = {
    workstation = den.lib.parametric.atLeast {
      includes = [
        <chimera/boot>
        <chimera/networking>
        # <chimera/theming>
        <chimera/wayland/niri>
        # <chimera/tailscale>
        <chimera/xdg>
      ];
    };
    laptop = den.lib.parametric.atLeast {
      includes = [
        <chimera/boot/graphical>
        # <chimera/boot/secure>
        # <chimera/performance/responsive>
        <chimera/power-mgmt>
        <chimera/workstation>
      ];
    };
  };
}
