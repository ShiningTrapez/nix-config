{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options = {
    user = mkOption {
      type = types.str;
      description = "The User Name of the User to Configure.";
    };

    homeDir = mkOption {
      type = types.str;
      default = "/home/${config.user}";
      defaultText = ''"/home/${config.user}"'';
      description = "Home directory; defaults to /home/<user>.";
    };
  };
}
