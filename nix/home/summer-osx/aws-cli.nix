{
  config,
  lib,
  pkgs,
  ...
}:
let
  # the item `op plugin init aws` uses, for SDK tools the plugin can't wrap, like sls under pnpm
  opAwsCredentials = pkgs.writeShellApplication {
    name = "op-aws-credentials";
    runtimeInputs = [ config.programs._1password-shell-plugins.package ];
    text = ''
      item=op://itnk7smgjjct3knlpk44qvhgmm/b3n27ds2ioxueawanew24ogwsi
      id=$(op read --account my.1password.com "$item/Access Key ID")
      secret=$(op read --account my.1password.com "$item/Secret Access Key")
      printf '{"Version": 1, "AccessKeyId": "%s", "SecretAccessKey": "%s"}' "$id" "$secret"
    '';
  };
in
{
  programs._1password-shell-plugins.plugins = [ pkgs.awscli2 ];
  programs.awscli.enable = true;
  programs.awscli.settings.default = { };

  # the shell plugin rejects profiles with credential_process, so it stays off default
  programs.awscli.settings."profile summer".credential_process = lib.getExe opAwsCredentials;
}
