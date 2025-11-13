{inputs, ...}: {
  unify.modules.neovim = {
    home = {...}: {
      programs.nvf.settings.vim = {
        assistant = {
          avante-nvim = {
            enable = true;
            setupOpts = {
              provider = "copilot";
              auto_suggestions_provider = "copilot";
              behaviour = {
                auto_suggestions = true;
                enable_token_counting = true;
              };
              suggestion = {
                debounce = 900; # Default was 600
                throttle = 800; # Default was 600
              };
              windows = {
                position = "right";
                width = 30;
                wrap = true;
              };
            };
          };
          copilot.enable = true;
        };
      };
    };
  };
}
