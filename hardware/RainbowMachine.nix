# Generated with nixos-generate-config
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [];

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

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp68s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp70s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
