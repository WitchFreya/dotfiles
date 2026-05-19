{ pkgs, ... }:
pkgs.buildNpmPackage (finalAttrs: {
  pname = "obsidian.plugins.relay";
  version = "0.8.0";

  src = pkgs.fetchgit {
    name = finalAttrs.pname;
    url = "https://github.com/No-Instructions/Relay.git";
    hash = "sha256-4+MbrXBnkFgj0PNZr5BN0jILM1KhIl+kQQpVTySyf30=";
    leaveDotGit = true;
    rev = finalAttrs.version;
  };

  npmDepsHash = "sha256-/1MmrZRzVyAOPVhcc5dB/zTikMh/BwI4Lm9cVyJFhwo=";

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
