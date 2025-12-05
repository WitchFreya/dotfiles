{ pkgs, ... }:
pkgs.buildNpmPackage (finalAttrs: {
  pname = "obsidian.plugins.relay";
  version = "0.6.1";

  src = pkgs.fetchgit {
    name = finalAttrs.pname;
    url = "https://github.com/No-Instructions/Relay.git";
    hash = "sha256-n1WnXJXeLqKq6WmTZKU2c1nZ6IZ4IK01gv1oDdZlyNA=";
    leaveDotGit = true;
    tag = finalAttrs.version;
  };

  npmDepsHash = "sha256-w4IvtFxWcQr1noHTL9HuR3Q5COfG/9EnqKjLDCq4TW8=";

  nativeBuildInputs = with pkgs; [ git ];

  makeCacheWritable = true;

  installPhase = ''
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./main.js $out/main.js
    cp ./styles.css $out/styles.css
  '';
})
