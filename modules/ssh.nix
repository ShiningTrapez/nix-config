{config, lib, ...}: {
  home.file.".ssh/allowed_signers".text = ''
    * ${builtins.readFile config.vcs.user.signingKey}
    * ${builtins.readFile config.vcs.workUser.signingKey}
  '';

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github gh github.com gitlab gl gitlab.com" = {
        user = "git";
        identitiesOnly = true;
        extraOptions = {
          RequestTTY = "no";
        };
      };

      "github gh github.com" = lib.hm.dag.entryAfter ["github gh github.com gitlab gl gitlab.com"] {
        hostname = "github.com";
        identityFile = "~/.ssh/id_github";
      };

      "gitlab gl gitlab.com" = lib.hm.dag.entryAfter ["github gh github.com gitlab gl gitlab.com"] {
        hostname = "gitlab.com";
        identityFile = "~/.ssh/id_gitlab";
      };

      "foxtech" = {
        hostname = "foxtech.machine.church";
        identityFile = "~/.ssh/id_hetzner";
      };
    };
  };
}
