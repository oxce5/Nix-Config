{
  unify.modules.neovim = {
    home = {
      programs.nvf = {
        vim.settings = {
          dashboard.dashboard-nvim = {
            enable = true;
            setupOpts = {
              theme = "doom";
              config = {
                header = [
                  "                          ⢀⣀⣀⠸⠿⠿⢿⣿                     "
                  "                          ⢸⡟⠛   ⢸⣿                     "
                  "                          ⣸⡇   ⣶⣾⣿                     "
                  "                        ⢸⣿⣿⡇   ⠿⠿⠿   ⣀⣸⡿⣃⡀   ⣀⡀        "
                  "                     ⣠⣤ ⠘⠛⠛⠃         ⣿⡇ ⢹⡇ ⢠⣤⠻⢣⣤       "
                  "                    ⣶⡛⠛            ⢰⣶⠛⠃ ⠙⢳⣶⡞⠛ ⢸⣿       "
                  "                  ⢰⣿⣿⠁             ⢸⣿         ⢸⣿       "
                  "       ⢀⣀⣀⣀⣀⣀⣀⣀   ⢸⣿⣿⠁ ⣀⣀⣀⣀⣀⣀⣀⣀⣀⡀ ⣿⡇          ⢸⣿       "
                  "      ⣤⣼⣿⣿⣿⣿⣿⣿⣿⣤⡄ ⠘⠛⣿⣧⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣤⣿⡇  ⢠⣤     ⣤⣼⣿⣤⡄     "
                  "      ⠉⢹⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇ ⣶⡎⠉   ⢰⣶⣿⣿⣿⠉⠁     "
                  "    ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⣀⣀⣀⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿    "
                  "    ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    "
                  "    ⠈⠉⠉⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠉⠉⠉    "
                  "    ⢰⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶    "
                  "    ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠃ ⠛⢻⣿⣿⣿⣿⣿⡿⠛⠃ ⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    "
                  "    ⠘⠛⠛⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠉     ⠉⢻⣿⣿⠋⠁    ⠈⠉⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠛⠛    "
                  "      ⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿   ⢰⣶   ⠈⠉⠉   ⢰⣶   ⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⡆     "
                  "      ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇   ⣿⡇ ⣿⡇      ⣿⡏⠉⣿⡆   ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇     "
                  "      ⠛⠛⠛⣿⣿⣿⣿⣿⣿⣿⣇⣀  ⠛⠃ ⠛⠃      ⠛⠃ ⠛⠃ ⢀⣠⣿⣿⣿⣿⣿⣿⣿⡟⠛⠛⠃     "
                  "       ⢠⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⡄ ⢠⣤         ⢠⣤   ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣤       "
                  "         ⣿⣿⣿⣿⡏ ⢻⣿⣿     ⣶⣶⣶⣶⣶⣶⣶⣶⣶⡆  ⠠⠶⣿⣿⣿⠁⠈⣿⣿⣿⣿⡏        "
                  "         ⠿⢿⣿⣿⡇   ⠿⣀⣀   ⠿⢇⣀   ⣀⣀⠿⠇  ⢀⣀⠿⠇   ⣿⣿⣿⠿⠇        "
                  "          ⠘⠛⣿⡇    ⠛⠛⣤⣤⣤ ⠘⠛⣤⣤⣤⡟⠛ ⢠⣤⣤⡜⠛     ⣿⡟⠛          "
                  "            ⠉⠁      ⠛⠛⠛⣤⣤⣤⣿⣿⣿⣧⣤⣤⡜⠛⠛⠃      ⠉⠁           "
                  "                                                       "
                ];
                center = [
                  {
                    icon = " ";
                    key = "f";
                    desc = "Find File          ";
                    action = "Yazi";
                    key_format = " %s";
                  }
                  {
                    icon = " ";
                    key = "n";
                    desc = "New File                   ";
                    action = "ene | startinsert";
                    key_format = " %s";
                  }
                  {
                    icon = " ";
                    key = "g";
                    desc = "Find Text                   ";
                    action = "lua Snacks.dashboard.pick('live_grep')";
                    key_format = " %s";
                  }
                  {
                    icon = " ";
                    key = "r";
                    desc = "Recent Files                   ";
                    action = "lua Snacks.dashboard.pick('oldfiles')";
                    key_format = " %s";
                  }
                  {
                    icon = " ";
                    key = "s";
                    desc = "Restore Session                   ";
                    section = "session";
                    key_format = " %s";
                  }
                  {
                    icon = " ";
                    key = "q";
                    desc = "Quit                   ";
                    action = ":qa";
                    key_format = " %s";
                  }
                ];
              };
            };
          };
        };
      };
    };
  };
}
