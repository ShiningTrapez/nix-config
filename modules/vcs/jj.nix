{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    delta # https://github.com/dandavison/delta
  ];

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = config.vcs.user.name;
        email = config.vcs.user.email;
      };

      ui = {
        editor = config.vcs.editor;
        merge-editor = config.vcs.editor;
        default-command = ["st"];
        diff-formatter = ":git";
        conflict-marker-style = "git";
        movement.edit = true;
        log-word-wrap = true;
        show-cryptographic-signatures = true;

        pager = "delta";
        streampager = {
          wrapping = "word";
          interface = "quit-quickly-or-clear-output";
        };
      };

      diff.git.context = config.vcs.diffContext;
      merge-tools.delta = {
        diff-invocation-mode = "file-by-file";
        diff-expected-exit-codes = [0 1];
      };

      aliases = {
        init = ["git" "init"];
      };

      revset-aliases = {
        # revent rewriting commits authored by other users
        "immutable_heads()" = "builtin_immutable_heads() | (trunk().. & ~mine())";
      };

      template-aliases = {
        # x days/hours/seconds ago
        "format_timestamp(timestamp)" = "timestamp.ago()";

        # display name and email
        "format_short_signature(signature)" = "signature";

        "format_short_cryptographic_signature(sig)" = "if(sig, sig.status(), \"(no sig)\",)";
      };

      revsets = {
        short-prefixes = "(main..@)::";
      };

      signing = {
        behavior = "own";
        backend = "ssh";
        key = config.vcs.user.signingKey;
        backends.ssh.allowed-signers = config.vcs.allowedSigners;
      };

      git = {
        sign-on-push = true;
        private-commits = "description('wip:*') | description('private:*')";
      };

      merge = {
        hunk-level = "word";
      };

      fix.tools.nix-fmt = {
        command = [
          "nix"
          "fmt"
        ];
        patterns = ["glob:'**/*.nix'"];
      };

      # No equivalent to condition = "hasconfig:remote..." in JJ right now
      "--scope" = [
        {
          "--when".repositories = ["${config.home.homeDirectory}/Work"];
          user = {
            name = config.vcs.workUser.name;
            email = config.vcs.workUser.email;
          };

          signing.key = config.vcs.workUser.signingKey;
        }
      ];
    };
  };
}
