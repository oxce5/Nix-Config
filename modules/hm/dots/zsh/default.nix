{
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh.shellAliases = ''
    alias rebuild="/home/oxce5/hydenix/scripts/nixos-rebuild.sh"
    alias nvim="/home/oxce5/hydenix/scripts/nvim.sh"
    '';
  };
}
