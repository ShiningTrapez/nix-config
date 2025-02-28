{ config, ...}: {
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    powerManagement.enable = false;
    # powerManagement.finegrained = true;
    open = true;
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
