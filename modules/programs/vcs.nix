{
  unify.modules.development.home = {
    programs = {
      git = {
        enable = true;
        lfs.enable = true;
        settings = {
          user = {
            name = "avg.gamer";
            email = "avg.gamer@proton.me";
          };
          aliases = {
            ci = "commit";
            co = "checkout";
            st = "status";
          };
        };
        signing = {
          format = "ssh";
          key = "~/.ssh/id_ed25519.pub";
          signByDefault = true;
        };
        extraConfig = {
          init.defaultBranch = "main";
          pull.rebase = true;
          rerere.enabled = true;
          column.ui = "auto";
          fetch.prune = true;
          interactive.singlekey = true;
          gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";
        };
      };
      jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "avg.gamer";
            email = "avg.gamer@proton.me";
          };
          signing = {
            behavior = "own";
            backend = "ssh";
            key = "~/.ssh/id_ed25519.pub";
          };
          git = {
            sign-on-push = true;
          };
        };
      };
      jjui.enable = true;
      difftastic.enable = true;
    };
  };
}
