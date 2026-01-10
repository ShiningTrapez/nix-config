{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    delta # https://github.com/dandavison/delta
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    iniContent.gpg.format = pkgs.lib.mkForce "ssh";

    settings = {
      user = config.vcs.user;

      alias = {
        update = "!git fetch && git pull";

        ref = "show --quiet --format=reference";
        short = "show --quiet --format=%h";
        latest = "show -c";

        edit = "commit --amend --only";
        ff = "merge --ff-only";
        all = "!acpp() { git add . && git commit -aqm \"$1\" &&
          git pull -q --no-progress && git push -q; }; acpp";
        undo = "reset --hard @{1}";

        summary = "!which onefetch 2>&1 >/dev/null &&
          onefetch --nerd-fonts --no-art --no-color-palette -d created -d authors -d contributors -d dependencies";
      };

      # Delta
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        dark = true;
        navigate = true;
        side-by-side = true;
      };

      # https://jvns.ca/blog/2024/02/16/popular-git-config-options/#fsckobjects-avoid-data-corruption
      transfer.fsckobjects = true;
      fetch.fsckobjects = true;
      receive.fsckObjects = true;

      # https://jvns.ca/blog/2024/02/16/popular-git-config-options/#submodule-stuff
      status.submoduleSummary = true;
      diff.submodule = "log";
      submodule.recurse = true;

      # https://blog.gitbutler.com/how-git-core-devs-configure-git/
      column.ui = "auto";
      branch.sort = "committerdate";
      tag.sort = "version:refname";
      init.defaultBranch = "main";
      help.autocorrect = "prompt";

      log.date = "iso";

      core = {
        editor = config.vcs.editor;
        fsmonitor = true;
        untrackedCache = true;
        autocrlf = "input";
        whitespace = "-space-before-tab,tab-in-indent";
      };

      diff = {
        context = config.vcs.diffContext;
        algorithm = "histogram";
        colorMoved = "plain";
        colorMovedWS = "allow-indentation-change";
        mnemonicPrefix = true;
        renames = "copies";
      };

      pull.rebase = true;

      # https://blog.gitbutler.com/git-tips-1-theres-a-git-config-for-that/#reuse-recorded-resolution
      rerere = {
        enabled = true;
        autoupdate = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
        missingCommitsCheck = "error";
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      merge = {
        conflictstyle = "zdiff3";
        keepbackup = false;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      # Allow # in Commit Messages
      commit.cleanup = "scissors";

      safe.directory = [
        "${config.home.homeDirectory}/.config/nixpkgs"
      ];

      # Signing
      signing.signByDefault = true;
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = config.vcs.allowedSigners;

      # Replace HTTP Remotes with SSH for Github and Gitlab
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
        "ssh://git@gitlab.com" = {
          insteadOf = "https://gitlab.com";
        };
      };
    };

    # https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix#L188
    # https://github.com/hazelweakly/nixos-configs/blob/21d1e90278b56c3e771db8a2f07945e053b44941/home/work.nix#L11
    includes = [
      {
        condition = "gitdir:${config.home.homeDirectory}/Work/**";
        contents = {user = config.vcs.workUser;};
      }
      {
        condition = "hasconfig:remote.*.url:git@github.com:bbc/**";
        contents = {user = config.vcs.workUser;};
      }
    ];

    # Local Config
    ignores = [".direnv"];
  };
}
