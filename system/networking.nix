{...}: {
  networking.hostName = "RainbowMachine";

  networking.networkmanager.enable = true;

  networking.extraHosts = ''
    127.0.0.1 www.sandbox.bbctvapps.co.uk
  '';

  networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
  ];

  networking.wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
      ControlPortOverNL80211 = false;
    };
  };

  networking.networkmanager.wifi.backend = "iwd";

  system.activationScripts = {
    rfkillUnblockWlan = {
      text = ''
        rfkill unblock wlan
      '';
      deps = [];
    };
  };
}
