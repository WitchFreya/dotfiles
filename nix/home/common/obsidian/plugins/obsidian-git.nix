{ pkgs, ... }:
pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian.plugins.obsidian-git";
  version = "2.35.1";

  src = pkgs.fetchFromGitHub {
    owner = "Vinzent03";
    repo = "obsidian-git";
    rev = finalAttrs.version;
    hash = "sha256-ExjfsN1UWPRSEiFt4YCiO2PDJuNnS0koVtDtRXgR5lc=";
  };

  pnpmDeps = pkgs.pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 2;
    hash = "sha256-qoQ7/PHeJst23ovf4HX7DOvIN+NLXba991kVcqs4WV8=";
  };

  nativeBuildInputs = with pkgs; [
    nodejs
    pnpm
    pnpm.configHook
  ];

  buildPhase = ''
    runHook preBuild
    pnpm run build
    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./main.js $out/main.js
    cp ./styles.css $out/styles.css
  '';
})
