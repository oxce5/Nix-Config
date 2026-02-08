{
  perSystem = {pkgs, ...}: {
    packages.java-debug = let
      inherit (pkgs) fetchFromGitHub makeWrapper maven;
    in
      maven.buildMavenPackage {
        pname = "java-debug";
        version = "0.53.2";

        src = fetchFromGitHub {
          owner = "microsoft";
          repo = "java-debug";
          rev = "31dd8ee33403f7365937cf77c653f2f5ec0960ba";
          hash = "sha256-R6FpJsmvfDANRRyP3bxodPvzo0tPHXVX1cjteYuAhYE=";
        };

        mvnHash = "sha256-euHHfRfyir0mj3ktNjEqbTkaq+r8y6QivvFLJfj/31A=";
        mvnBuildFlags = ["-U"];

        nativeBuildInputs = [makeWrapper];

        installPhase = ''
          mkdir -p $out/share/java-debug
          install -Dm644 com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar $out/share/java-debug/java-debug.jar
        '';

        meta = with pkgs.lib; {
          description = "Java Debugger";
          homepage = "https://github.com/microsoft/java-debug";
          license = licenses.epl10;
          maintainers = [];
        };
      };
  };
}
