{
  config,
  pkgs,
  ...
}: let
  craftyUser = "crafty";
  craftyBase = "/var/opt/minecraft";
  craftyRepo = "${craftyBase}/crafty/crafty-4";
  venvDir = "${craftyBase}/crafty/.venv";
in {
  users.users.${craftyUser} = {
    isSystemUser = true;
    createHome = false;
    group = craftyUser;
    shell = pkgs.bash;
  };

  users.groups.${craftyUser} = {};

  systemd.tmpfiles.rules = [
    "d ${craftyBase}/crafty 0755 ${craftyUser} ${craftyUser} -"
    "d ${craftyBase}/server 0755 ${craftyUser} ${craftyUser} -"
  ];

  systemd.services.crafty = {
    description = "Crafty Minecraft Server Manager";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "simple";
      User = craftyUser;
      WorkingDirectory = "${craftyBase}"; # This always exists
      ExecStart = "${venvDir}/bin/python3 ${craftyRepo}/main.py";
      Restart = "on-failure";
    };

    preStart = ''
      echo "=== Crafty PreStart ==="
      echo "Checking git..."
      which git || true

      echo "Checking python..."
      ${pkgs.python3}/bin/python3 --version || true

      echo "Checking if crafty repo exists..."
      if [ ! -d "${craftyRepo}" ]; then
        echo "Cloning repo..."
        ${pkgs.git}/bin/git clone https://gitlab.com/crafty-controller/crafty-4.git ${craftyRepo}
      fi

      echo "Checking venv..."
      if [ ! -d "${venvDir}" ]; then
        echo "Creating venv..."
        ${pkgs.python3}/bin/python3 -m venv ${venvDir}
      fi

      echo "Installing dependencies..."
      ${venvDir}/bin/pip3 install --no-cache-dir -r ${craftyRepo}/requirements.txt

      echo "=== PreStart Done ==="
    '';
  };

  environment.systemPackages = with pkgs; [
    git
    openjdk8
    python3
    python3Packages.pip
    python3Packages.virtualenv
  ];
}
