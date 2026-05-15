{ pkgs, ... }:
pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian.plugins.obsidian-git";
  version = "2.38.3";

  src = pkgs.fetchFromGitHub {
    owner = "Vinzent03";
    repo = "obsidian-git";
    rev = finalAttrs.version;
    hash = "sha256-LcFIpQHOLjCY4L2vCYBjBN/73Bfg5Wa+tXoVmcBMrbY=";
  };

  pnpmDeps = pkgs.fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 2;
    hash = "sha256-dMl6SXEuZlEIm1jOR6gI5hBBk236FItxga2cx2d8D0g=";
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
