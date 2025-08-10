_: {
  programs.lsd = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      blocks = [
        "permission"
        "size"
        "date"
        "name"
      ];
      classic = false;
      date = "+%d %b %y %X";
      dereference = true;
      hyperlink = "auto";
      ignore-globs = [
        ".git"
        "node_modules"
      ];
      layout = "tree";
      recursion = {
        depth = 1;
        enabled = true;
      };
      size = "short";
      sorting = {
        dir-grouping = "first";
      };
    };
  };
}
