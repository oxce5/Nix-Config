{...}: {
  programs = {
    yazi = {
      enable = true;
      initLua = ''
        require("git"):setup()
        require("relative-motions"):setup({ show_numbers="relative", show_motion = true, enter_mode ="first" })
      '';
      settings = import ./settings.nix;
      keymap = import ./keymap.nix;
    };
  };
}
