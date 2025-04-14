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
    sha256 = "ea59f0d5eceb86f790e54a826d1e947e970d3f9d"; # Replace with the actual sha256
  };

  buildinputs = [python3];

  # build steps
  unpackphase = ''
    echo "unpacking the repository"
    cp -r ${src} $out
  '';

  installphase = ''
    echo "installing crafty..."
    cd $out

    python3 -m venv .venv
    source .venv/bin/activate
    pip install --no-cache-dir -r crafty-4/requirements.txt

    mkdir -p $out/bin
    cat > $out/bin/crafty <<eof
    #!${stdenv.bash}/bin/bash
    cd $out/crafty-4
    source .venv/bin/activate
    exec python3 main.py "\$@"
    eof
    chmod +x $out/bin/crafty
  '';

  meta = with lib; {
    description = "crafty minecraft controller";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
