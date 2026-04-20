{
  config,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

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
    };
  };

  home = {
    file = {
      ".ssh/config".force = true;
      ".ssh/allowed_signers".text = ''
        * ${builtins.readFile config.vcs.user.signingKey}
        * ${builtins.readFile config.vcs.workUser.signingKey}
      '';
    };

    # Fix SSH Permissions
    # # https://github.com/nix-community/home-manager/issues/322
    activation = {
      fixSshPermissions = lib.hm.dag.entryAfter ["linkGeneration"] ''
        run install -d -m 0700 "$HOME/.ssh"
        if [ -L "$HOME/.ssh/config" ]; then
          src="$(readlink -f "$HOME/.ssh/config")"
          run rm -f "$HOME/.ssh/config"
          run install -m 0600 "$src" "$HOME/.ssh/config"
        fi
      '';
    };
  };
}
