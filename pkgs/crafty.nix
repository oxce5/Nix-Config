{
  lib,
  stdenv,
  python3,
  fetchgit,
  ...
}:
stdenv.mkDerivation rec {
  pname = "crafty";
  version = "4"; # Adjust version if needed

  src = fetchgit {
    url = "https://gitlab.com/crafty-controller/crafty-4.git";
    rev = "master"; # You can lock to a specific commit hash if you want
    sha256 = "1lq51b8hppn6n6jnd3fvz1p451piflvphlm42n6nfz2awkgx6c6g"; # Replace with the actual sha256
  };

  nativeBuildInputs = [python3];

  buildInputs = with python3.pkgs; [
    apscheduler
    argon2-cffi
    # cached_property (not in Nixpkgs; see below)
    colorama
    croniter
    cryptography
    # libgravatar (not in Nixpkgs; see below)
    nh3
    packaging
    peewee
    psutil
    pyopenssl
    pyjwt
    pyyaml
    requests
    # termcolor (not in Nixpkgs; see below)
    tornado
    tzlocal
    jsonschema
    orjson
    prometheus-client
    pillow
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/crafty
    cp -r . $out/share/crafty

    # Set up Python virtual environment
    python3 -m venv $out/share/crafty/.venv
    source $out/share/crafty/.venv/bin/activate

    # Link Nix-provided Python packages
    for pkg in ${lib.concatStringsSep " " buildInputs}; do
      find $pkg -type d -name "*.egg-info" -exec cp -r {} $out/share/crafty/.venv/lib/python*/site-packages/ \;
      find $pkg -type d -name "*.dist-info" -exec cp -r {} $out/share/crafty/.venv/lib/python*/site-packages/ \;
      find $pkg -type f -name "*.py" -exec cp {} $out/share/crafty/.venv/lib/python*/site-packages/ \;
      find $pkg -type d -name "*.so" -exec cp -r {} $out/share/crafty/.venv/lib/python*/site-packages/ \;
    done

    # Create executable script
    mkdir -p $out/bin
    cat > $out/bin/crafty <<EOF
    #!${stdenv.shell}
    cd $out/share/crafty
    source .venv/bin/activate
    exec python3 main.py "\$@"
    EOF
    chmod +x $out/bin/crafty

    runHook postInstall
  '';

  meta = with lib; {
    description = "Crafty Minecraft Controller";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
