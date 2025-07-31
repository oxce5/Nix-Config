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
    zsh.shellAliases = {
      rebuild = "/home/oxce5/hydenix/scripts/nixos-rebuild.sh";
      nvim = "/home/oxce5/hydenix/scripts/nvim.sh";
    };
  };
}
