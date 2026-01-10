{config, ...}: {
  home.file.".ssh/allowed_signers".text = ''
    * ${builtins.readFile config.vcs.user.signingKey}
    * ${builtins.readFile config.vcs.workUser.signingKey}
  '';
}
