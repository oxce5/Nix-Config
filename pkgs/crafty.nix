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

  buildInputs = [python3];

  # Build steps (just install dependencies and set up the venv)
  installPhase = ''
    mkdir -p $out/lib/crafty
    cp -r . $out/lib/crafty/crafty-4
    cd $out/lib/crafty/crafty-4

    python3 -m venv .venv
    source .venv/bin/activate
    pip install --no-cache-dir -r requirements.txt

    mkdir -p $out/bin
    cat > $out/bin/crafty <<EOF
    #!${stdenv.bash}/bin/bash
    cd $out/lib/crafty/crafty-4
    source .venv/bin/activate
    exec python main.py "\$@"
    EOF
    chmod +x $out/bin/crafty
  '';

  meta = with lib; {
    description = "Crafty Minecraft Controller";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
