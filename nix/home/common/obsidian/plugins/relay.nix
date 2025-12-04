{ pkgs, ... }:
pkgs.buildNpmPackage (finalAttrs: {
  pname = "obsidian.plugins.relay";
  version = "0.6.1";

  src = pkgs.fetchgit {
    name = finalAttrs.pname;
    url = "https://github.com/No-Instructions/Relay.git";
    hash = "sha256-8L7OyMxgfJwKHt6tJ3eM6YR8iuFvnO8ciRowBIrGgoo=";
    leaveDotGit = true;
    rev = finalAttrs.version;
  };

  npmDepsHash = "sha256-n/jGuzvKQ0ypKN5iy8B3O7mEOkIgAPZCh2oMEQ071ek=";

  nativeBuildInputs = with pkgs; [ git ];

  makeCacheWritable = true;

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./main.js $out/main.js
    cp ./styles.css $out/styles.css
  '';
})
