{...}: {
  programs.lsd = {
    enable = true;
    # Default in home-manager/84d262115e10ad321ef01cd85903d0f5c3ec113f
    # enableAliases = true;
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
