{ pkgs, ... }:
pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian.plugins.obsidian-git";
  version = "2.36.0";

  src = pkgs.fetchFromGitHub {
    owner = "Vinzent03";
    repo = "obsidian-git";
    rev = finalAttrs.version;
    hash = "sha256-3r4nxIWx7j6j7V3kbHt1nJG7hBJazxzdDD4m8DbQoWw=";
  };

  pnpmDeps = pkgs.fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 2;
    hash = "sha256-pEWuqWLfqCYOfVNgiqayGUNAKC2VkfOfu7yXfqqhnl4=";
  };

  nativeBuildInputs = with pkgs; [
    nodejs
    pnpm
    pnpmConfigHook
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
