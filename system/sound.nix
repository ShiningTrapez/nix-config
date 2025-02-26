{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        # Experimental = true;
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Control Media Player with Bluetooth
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [
      "network.target"
      "sound.target"
    ];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # Disable "Headset Mode" switching
    wireplumber = {
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/11-bluetooth-policy.conf" ''
          wireplumber.settings = { bluetooth.autoswitch-to-headset-profile = false }
        '')
      ];
    };
  };
}
