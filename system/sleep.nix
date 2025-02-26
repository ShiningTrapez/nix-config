{...}:
# Disable Sleep
{
  powerManagement.enable = false;
  systemd = {
    targets = {
      sleep = {
        enable = false;
        unitConfig.DefaultDependencies = "no";
      };

      suspend = {
        enable = false;
        unitConfig.DefaultDependencies = "no";
      };

      hibernate = {
        enable = false;
        unitConfig.DefaultDependencies = "no";
      };

      "hybrid-sleep" = {
        enable = false;
        unitConfig.DefaultDependencies = "no";
      };
    };
  };
}
