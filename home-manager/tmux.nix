{ pkgs, ... }:
{
  programs.tmux = {
    enable = true; # Enable tmux in Home Manager

    plugins = with pkgs.tmuxPlugins; [
      sensible         # Better default behavior
      yank             # System clipboard integration
      resurrect        # Save/restore sessions
      tokyo-night-tmux
      (pkgs.tmuxPlugins.mkTmuxPlugin {
        pluginName = "tmux-command-palette";
        version = "unstable-2025-03-12";
        src = pkgs.fetchFromGitHub {
          owner = "lost-melody";
          repo = "tmux-command-palette";
          rev = "96200a32c370bba60ea07a663014d50b76bd8de3";
          sha256 = "0kll9iwws71mbdrkv69dhcjg89214c5z70x6zajz8qyil63daw7h";
        };
        extraConfig = ''
          set -g @cmdpalette-key-prefix 'prefix ?'
          set -g @cmdpalette-key-root 'prefix BSpace'
          set -g @cmdpalette-key-copy-mode-vi 'C-/'
        '';
      })
    ];

    extraConfig = ''
      set -g @plugin 'fabioluciano/tmux-tokyo-night'
      set -g @theme_variation 'moon'
      set -g @theme_left_separator ''
      set -g @theme_right_separator ''
      set -g @theme_plugins 'datetime'
      run '~/tmux/plugins/tpm/tpm'
    '';
    mouse = true;
    prefix = "C-s";
  };
}
