{
  lib,
  fetchFromGitHub,
  jre,
  makeWrapper,
  maven,
}:
maven.buildMavenPackage rec {
  pname = "java-debug";
  version = "0.53.2";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = pname;
    rev = "614b10df99acc34ced35fc50b9b70a8191719e2c";
    hash = "sha256-1CPlGFae7J5ND4eoEkh/Lz6jve/epjBsyioKDq9sMfc=";
  };

  mvnHash = "sha256-euHHfRfyir0mj3ktNjEqbTkaq+r8y6QivvFLJfj/31A=";
  mvnBuildFlags = ["-U"];

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/share/java-debug
    install -Dm644 com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar $out/share/java-debug/java-debug.jar
  '';

  meta = with lib; {
    description = "Java Debugger";
    homepage = "https://github.com/microsoft/java-debug";
    license = licenses.epl10;
    maintainers = [];
  };
}
