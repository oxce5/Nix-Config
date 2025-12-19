{
  unify.modules.sillytavern = {
    nixos = {
      services.sillytavern = {
        enable = true;
        port = 8000;
      };
    };
  };
}
