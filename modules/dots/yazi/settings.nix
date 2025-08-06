{
  settings = {
    opener = {
      extract = [
        {
          run = "ouch d -y \"%*\"";
          desc = "Extract here with ouch";
          for = "windows";
        }
        {
          run = "ouch d -y \"$@\"";
          desc = "Extract here with ouch";
          for = "unix";
        }
      ];
    };
    open = {
      prepend_rules = [
        {
          mime = "application/zip";
          use = "extract";
        }
        {
          mime = "application/x-tar";
          use = "extract";
        }
        {
          mime = "application/gzip";
          use = "extract";
        }
        {
          mime = "application/x-bzip-compressed-tar";
          use = "extract";
        }
        {
          mime = "application/x-xz-compressed-tar";
          use = "extract";
        }
      ];
    };
    plugin = {
      prepend_previewers = [
        {
          mime = "application/zip";
          run = "ouch";
        }
        {
          mime = "application/x-tar";
          run = "ouch";
        }
        {
          mime = "application/x-bzip2";
          run = "ouch";
        }
        {
          mime = "application/x-7z-compressed";
          run = "ouch";
        }
        {
          mime = "application/x-rar";
          run = "ouch";
        }
        {
          mime = "application/x-xz";
          run = "ouch";
        }
        {
          mime = "application/xz";
          run = "ouch";
        }
      ];
      prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
  };
}
