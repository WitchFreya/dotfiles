{ pkgs, ... }:
pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian.plugins.obsidian-git";
  version = "2.36.1";

  src = pkgs.fetchFromGitHub {
    owner = "Vinzent03";
    repo = "obsidian-git";
    rev = finalAttrs.version;
    hash = "sha256-NQs2ZpkstVJYogucBvP3DaYfJ1dFKr3zxNakX0IpQAE=";
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
