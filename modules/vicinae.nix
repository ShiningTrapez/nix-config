{pkgs, ...}: let
  inherit (pkgs) vicinae wl-clipboard;
in {
  home.packages = [
    vicinae
    wl-clipboard
  ];

  # https://haseebmajid.dev/posts/2023-10-08-how-to-create-systemd-services-in-nix-home-manager/
  systemd.user.services.vicinae-server = {
    Unit = {
      Description = "Vicinae Server";
    };

    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
      ExecStart = "${vicinae}/bin/vicinae server";
      Restart = "on-failure";
      RestartSec = "5s";
      Type = "simple";
      StandardOutput = "journal";
      StandardError = "journal";
    };
  };
}
