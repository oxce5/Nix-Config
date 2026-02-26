{inputs, ...}: {
  unify.modules.tmux = {
    home = {pkgs, ...}: {
      home.packages = with pkgs; [
        plusultra.tmux
      ];
    };
  };
}
