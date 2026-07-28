_: {
  programs.starship = {
    enable = true;
    settings = {
      format = "[┌─{](dimmed blue) \${custom.rain8ow-hostname}\${custom.hostname}$hostname / $sudo$username [}─\\[$directory$nix_shell$package$rust$nodejs$haskell$gradle$java$kotlin\\]\${env_var.DIRENV_DIFF}─>](dimmed blue)\n[└─>](dimmed blue) $jobs";
      right_format = "$git_branch$git_commit$git_metrics$git_state$git_status";

      directory.format = "[$path]($style)[$read_only]($read_only_style)";

      env_var.DIRENV_DIFF = {
        symbol = "DIRENV";
        format = "[[-\\[](dimmed blue)$symbol[\\]](dimmed blue)]($style)";
        description = "Direnv Diff in Environment";
        style = "dimmed white";
      };

      git_commit = {
        style = "dimmed white";
        format = "[#$hash$tag]($style)";
        only_detached = false;
      };

      git_branch = {
        format = " [$symbol$branch(:$remote_branch)]($style)";
        style = "dimmed blue";
      };

      git_state.format = " \\([$state( $progress_current/$progress_total)]($style)\\)";

      git_status = {
        format = " ([\\[$typechanged$all_status$ahead_behind\\]]($style))";
        ignore_submodules = true;
        typechanged = "T";
      };

      git_metrics = {
        disabled = false;
        ignore_submodules = true;
        only_nonzero_diffs = true;
        format = "( ([+$added]($added_style))(/[-$deleted]($deleted_style)))";
      };

      jobs.format = "[$symbol( \($number\))]($style) ";

      nix_shell = {
        format = " [$symbol$state( ($name))]($style)";
        disabled = false;
        impure_msg = "[impure](bold red)";
        pure_msg = "[pure](bold green)";
        style = "bold blue";
        symbol = " ";
      };

      hostname = {
        style = "dimmed";
        format = "@[$hostname]($style)";
        ssh_only = true;
      };

      custom.hostname = {
        description = "Normal Hostname for Normal Machine";
        command = "hostname";
        when = "[ $(hostname) != \"Rain8owMachine\" ]";
        shell = "sh";
        format = "@[$output]($style)";
      };

      custom.rain8ow-hostname = {
        description = "Rain8ow Hostname for Rain8ow Machine";
        command = "echo \"Rain8owMachine\" | lolcat -ftp 0.3 2> /dev/null";
        when = "[ $(hostname) = \"Rain8owMachine\" ]";
        shell = "sh";
        format = "@$output";
        ignore_timeout = true;
      };

      time = {
        disabled = false;
        style = "bold blue";
        format = "[$time]($style)";
      };

      username = {
        style_user = "bold blue";
        format = "[$user]($style)";
        show_always = true;
      };

      package = {
        style = "dimmed cyan";
        format = "[@](dimmed white)[$version]($style)";
      };

      gradle = {
        style = "dimmed cyan";
        format = " [$symbol($version)]($style)";
      };

      java = {
        style = "dimmed red";
        format = " [$symbol($version)]($style)";
      };

      kotlin = {
        style = "dimmed blue";
        format = " [$symbol($version)]($style)";
      };

      haskell = {
        style = "dimmed purple";
        format = " [$symbol($version)]($style)";
      };

      rust = {
        style = "dimmed red";
        format = " [$symbol($version)]($style)";
      };

      nodejs = {
        style = "dimmed green";
        format = " [$symbol($version)]($style)";
      };
    };
  };
}
