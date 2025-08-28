NOTE/s:
-config.ini must be copied from the /nix/store directory of jdt-language-server. Otherwise the LSP will fail and throw exitcode 13. 
-Configuration cannot be set to the /nix/store, otherwise it will also throw exit code 13, set it to .cache instead.
-"Java executable cannot be resolved" This issue can be resolved with rm -rf .cache/nvf/jdtls/workspace
