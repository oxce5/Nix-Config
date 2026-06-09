{
  perSystem = {pkgs, ...}: {
    packages.iosevka-chimera = let
      inherit (pkgs) stdenvNoCC iosevka;
    in (iosevka.override {
      set = "Chimera";
      privateBuildPlan = ''
        [buildPlans.IosevkaChimera]
        family = "Iosevka Chimera"
        spacing = "normal"
        serifs = "sans"
        noCvSs = true
        exportGlyphNames = false

        [buildPlans.IosevkaChimera.ligations]
        inherits = "haskell"

        [buildPlans.IosevkaChimera.weights.Regular]
        shape = 400
        menu = 400
        css = 400

        [buildPlans.IosevkaChimera.weights.Bold]
        shape = 700
        menu = 700
        css = 700

        [buildPlans.IosevkaChimera.slopes.Upright]
        angle = 0
        shape = "upright"
        menu = "upright"
        css = "normal"

        [buildPlans.IosevkaChimera.slopes.Italic]
        angle = 9.4
        shape = "italic"
        menu = "italic"
        css = "italic"
      '';
    });
  };
}
