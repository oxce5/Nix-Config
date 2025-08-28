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
    rev = "a209e39b9e07e5b2eacb74a2a2250da99c6751e3";
    hash = "sha256-1CPlGFae7J5ND4eoEkh/Lz6jve/epjBsyioKDq9sMfc=";
  };

  mvnHash = "sha256-ULjkfEDfij/kpj5CTA2vN0jzj7V6pTd/EUy4bmnltJ8=";

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
