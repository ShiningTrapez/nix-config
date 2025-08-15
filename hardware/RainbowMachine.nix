# Generated with nixos-generate-config
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];

      kernelModules = [];
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0e8f0138-f35a-4a9f-87a8-e50f6be5b4ef";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B95B-CE20";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/1117a1dc-e624-47ab-b882-dafd5dddf29f";
    }
  ];

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
