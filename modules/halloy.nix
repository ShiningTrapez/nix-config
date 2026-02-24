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
        nickname = "Sophia";
        server = "orangeclock.work";
        channels = [ "#istudiedtheterminal" ];
      };
    };
  };
}
