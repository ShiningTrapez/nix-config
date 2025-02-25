{ config, ... }:

{
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = false;
    # powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
  };

  hardware.graphics.enable = true;

  services.xserver = {
    videoDrivers = ["nvidia"];
    xkb = {
      layout = "gb";
      variant = "";
    };
  };
}