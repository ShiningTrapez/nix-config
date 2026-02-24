{...}: {
  # https://halloy.chat/configuration.html
  programs.halloy = {
    enable = true;
    settings = {
      scale_factor = 2.0;

      buffer.nickname.brackets = {
        left = "<";
        right = ">";
      };

      servers.terminal = {
        nickname = "sophia";
        server = "orangeclock.work";
        channels = [ "#istudiedtheterminal" ];
      };
    };
  };
}
