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
    package = pkgs.gitAndTools.gitFull;
    userName = "Sophia Bitterstar";
    userEmail = "sophia@shiningtrapezohedron.com";

    iniContent.gpg.format = pkgs.lib.mkForce "ssh";

    extraConfig = {
      alias = {
        a = "add";
        b = "branch";
        f = "fetch";
        p = "push";
        pf = "push —force-with-lease";
        pu = "pull";
        s = "status";

        ref = "show --quiet --format=reference";
        short = "show --quiet --format=%h";
        latest = "show -c";

        edit = "commit --amend --only";
        ff = "merge --ff-only";
        commitall = "!acpp() { git add . && git commit -aqm \"$1\" &&
          git pull -q --no-progress && git push -q; }; acpp";
        undo = "reset --hard @{1}";

        summary = "!which onefetch 2>&1 >/dev/null &&
          onefetch --nerd-fonts --no-art -d created -d authors -d contributors -d dependencies";
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
        editor = "code -w";
        fsmonitor = true;
        untrackedCache = true;
        autocrlf = "input";
        whitespace = "-space-before-tab,tab-in-indent";
      };

      diff = {
        context = 10;
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
      user.signingkey = "${config.home.homeDirectory}/.ssh/id_github.pub";
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";

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
    includes = let
      workInfo = {
        user = {
          name = "Peter Clay Holden Morris-Hind";
          email = "peter.morris-hind@bbc.co.uk";
          signingkey = "${config.home.homeDirectory}/.ssh/id_github_work.pub";
        };
      };
    in [
      {
        condition = "gitdir:${config.home.homeDirectory}/Work/**";
        contents = workInfo;
      }
      {
        condition = "hasconfig:remote.*.url:git@github.com:bbc/**";
        contents = workInfo;
      }
    ];

    # Local Config
    ignores = [".direnv"];
  };

  home.file.".ssh/allowed_signers".text = ''
    * ${builtins.readFile "${config.home.homeDirectory}/.ssh/id_github.pub"}
    * ${builtins.readFile "${config.home.homeDirectory}/.ssh/id_github_work.pub"}
  '';
}
