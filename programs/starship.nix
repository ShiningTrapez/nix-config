{ ... }: {
  programs.starship = {
    enable = true;
    settings = {
      format = "[┌─{](dimmed purple) \${custom.rainbow-hostname}\${custom.hostname}$hostname / $sudo$username [}─\\[$directory$package$rust$nodejs$haskell$gradle$java$kotlin\\]─>](dimmed purple)\n[└─>](dimmed purple) ";
      right_format = "$git_branch$git_commit$git_metrics$git_state$git_status";
      directory.format = "[$path]($style)[$read_only]($read_only_style)";

      git_commit = {
        style = "dimmed white";
        format = "[#$hash$tag]($style)";
        only_detached = false;
      };

      git_branch.format = " [$symbol$branch(:$remote_branch)]($style)";
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

      hostname = {
        style = "dimmed";
        format = "@[$hostname]($style)";
        ssh_only = true;
      };

      custom.hostname = {
        description = "Normal Hostname for Normal Machine";
        command = "hostname";
        when = "[ $(hostname) != \"RainbowMachine\" ]";
        shell = "sh";
        format = "@[$output]($style)";
      };

      custom.rainbow-hostname = {
        description = "Rainbow Hostname for Rainbow Machine";
        command = "echo \"RainbowMachine\" | lolcat -ftp 0.3";
        when = "[ $(hostname) = \"RainbowMachine\" ]";
        shell = "sh";
        format = "@$output";
        ignore_timeout = true;
      };

      # sudo = {
      #   disabled = false;
      #   symbol = "";
      #   style ="dimmed blue";
      #   format = "[\\[S\\]]($style)";
      # };

      time = {
        disabled = false;
        style = "bold purple";
        format = "[$time]($style)";
      };

      username = {
        style_user = "bold purple";
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
        style ="dimmed red";
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
        style ="dimmed green";
        format = " [$symbol($version)]($style)";
      };
    };
  };
}
