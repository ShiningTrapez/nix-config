{ pkgs, ... }: let
  vicinae = pkgs.callPackage ./vicinae.nix { };
in {
  home.packages = with pkgs; [
    vicinae
    wl-clipboard
  ];

  # https://haseebmajid.dev/posts/2023-10-08-how-to-create-systemd-services-in-nix-home-manager/
  systemd.user.services.vicinae-server = {
    Unit = {
      Description = "Vicinae Server";
    };

    Install = {
      WantedBy = [ "default.target" ];
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
