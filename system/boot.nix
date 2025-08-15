{pkgs, ...}: {
  boot = {
    tmp.cleanOnBoot = true;

    initrd.verbose = false;

    consoleLogLevel = 3;

    kernelParams = [
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

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    kernelPackages = pkgs.linuxPackages_cachyos-lto;
  };

  services.scx.enable = true;
}
