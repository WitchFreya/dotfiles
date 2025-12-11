{ pkgs, ... }:
pkgs.buildNpmPackage (finalAttrs: {
  pname = "obsidian.plugins.relay";
  version = "0.7.1";

  src = pkgs.fetchgit {
    name = finalAttrs.pname;
    url = "https://github.com/No-Instructions/Relay.git";
    hash = "sha256-/OGW32zwCI9ApMQ9CgenX2NwahXKUSlTOHSZx4Nj6cw=";
    leaveDotGit = true;
    tag = finalAttrs.version;
  };

  npmDepsHash = "sha256-n/jGuzvKQ0ypKN5iy8B3O7mEOkIgAPZCh2oMEQ071ek=";

  nativeBuildInputs = with pkgs; [
    git
    jq
  ];

  makeCacheWritable = true;

  # manifest.json needs to have the version set manually since they use git describe to set it in the build script.
  installPhase = ''
    mkdir -p $out
    jq '.version = "${finalAttrs.version}"' ./manifest.json > $out/manifest.json
    cp ./main.js $out/main.js
    cp ./styles.css $out/styles.css
  '';
})
