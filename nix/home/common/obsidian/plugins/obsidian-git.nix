{ pkgs, ... }:
pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian.plugins.obsidian-git";
  version = "2.37.1";

  src = pkgs.fetchFromGitHub {
    owner = "Vinzent03";
    repo = "obsidian-git";
    rev = finalAttrs.version;
    hash = "sha256-2zodtLlaQSdMPdTAuLE7AvAhVXe12coRAR4k5/ZeT5U=";
  };

  pnpmDeps = pkgs.fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 2;
    hash = "sha256-1oMTNk/3kDQQGecBGu1m4ECktJvdm3f0AD3lWdBfCP4=";
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
