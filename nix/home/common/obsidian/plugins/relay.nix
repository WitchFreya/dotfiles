{ pkgs, ... }:
pkgs.buildNpmPackage (finalAttrs: {
  pname = "obsidian.plugins.relay";
  version = "0.7.4";

  src = pkgs.fetchgit {
    name = finalAttrs.pname;
    url = "https://github.com/No-Instructions/Relay.git";
    hash = "sha256-hhATlETqfU0+I2qufHG9LoD5IBJOdQOkazG0HldxQbo=";
    leaveDotGit = true;
    rev = finalAttrs.version;
  };

  npmDepsHash = "sha256-00H9wDu7eMWTbMvwNTNCP3/0dzncPRRXF7Dyubf58Z4=";

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
