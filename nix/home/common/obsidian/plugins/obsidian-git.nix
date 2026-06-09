{ pkgs, ... }:
let
  # Workaround for https://github.com/NixOS/nixpkgs/issues/525627
  pnpmPatched = pkgs.pnpm.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace dist/pnpm.mjs \
        --replace-fail \
          'resourceLimits: this._workerResourceLimits' \
          'resourceLimits: this._workerResourceLimits, trackUnmanagedFds: false'
    '';
  });
in
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
    pnpm = pnpmPatched;
    fetcherVersion = 3;
    hash = "sha256-h1SZZF3GZaNniXptxzKeqP8ROvd17bBTjZQ9CHna5HY=";
  };

  nativeBuildInputs = [
    pkgs.nodejs
    pnpmPatched
    pkgs.pnpmConfigHook
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
