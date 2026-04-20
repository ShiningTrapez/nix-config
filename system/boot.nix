{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types optionals;

  mitigationParams = [
    "noibrs"
    "noibpb"
    "nopti"
    "nospectre_v2"
    "nospectre_v1"
    "l1tf=off"
    "nospec_store_bypass_disable"
    "no_stf_barrier"
    "mds=off"
    "tsx=on"
    "tsx_async_abort=off"
    "mitigations=off"
  ];

  baseParams = [
    "sysrq_always_enabled=1"
    "quiet"
    "splash"
    "loglevel=3"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
    "rd.udev.log_level=3"
    "kernel.nmi_watchdog=0"
    "nowatchdog"
  ];
in {
  options.performance.insecureDisableMitigations = mkOption {
    type = types.bool;
    default = false;
    description = "Disable CPU Security mitigations for Performance (insecure).";
  };

  config = {
    warnings = lib.mkIf config.performance.insecureDisableMitigations [
      "CPU mitigations disabled (performance.insecureDisableMitigations)."
    ];

    boot = {
      tmp.cleanOnBoot = true;
      initrd.verbose = false;
      consoleLogLevel = 3;

      kernelParams = baseParams ++ optionals config.performance.insecureDisableMitigations mitigationParams;

      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        timeout = 0;
      };

      kernelPackages = pkgs.linuxKernel.packagesFor (pkgs.cachyosKernels.linux-cachyos-latest.override {
        pname = "${pkgs.cachyosKernels.linux-cachyos-latest.pname}-shining";

        # Kernel Settings
        lto = "full";
        processorOpt = "x86_64-v4";
        autofdo = true;
      });

      # https://lea.moe/posts/function-keys-on-iqunix-m80/
      extraModprobeConfig = "options hid_apple fnmode=2";
    };
  };
}
