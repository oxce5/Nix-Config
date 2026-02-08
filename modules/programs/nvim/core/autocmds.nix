{inputs, ...}: {
  unify.modules.neovim = {
    home = {lib, ...}: {
      programs.nvf.settings.vim.autocmds = [
        {
          event = ["CursorHold"];
          desc = "Open diagnostic hover on CursorHold";
          callback = lib.generators.mkLuaInline ''
            function()
              local opts = { focusable = false }
              local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
              local col = vim.fn.col('.') - 1
              for _, diag in ipairs(diagnostics) do
                if diag.col <= col and col < diag.end_col then
                  vim.diagnostic.open_float(nil, opts)
                  return
                end
              end
            end
          '';
        }
        {
          event = ["FileType"];
          pattern = ["dashboard"];
          desc = "Attach and disable folding for dashboard file type";
          callback = lib.generators.mkLuaInline ''
            function()
              require("ufo").detach()
              vim.opt_local.foldenable = false
            end
          '';
        }
      ];
    };
  };
}
