{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.user = mkOption {
    type = types.str;
    description = "The User Name of the User to Configure.";
  };

  config = {
    user = "sophia";

    locale = {
      locale = "en_GB.UTF-8";
      timeZone = "Europe/London";
      keyMap = "uk";
    };

    razor.enable = false;
  };
}
