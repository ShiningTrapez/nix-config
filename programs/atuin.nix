{ ... }: {
  programs.atuin = {
    enable = true;
    settings = {
      dialect = "uk";
      update_check = false;
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "workspace";
      invert = true;
      exit_mode = "return-query";
      store_failed = true;
      enter_accept = true;
      dotfiles.enable = false;
    };
  };
}
