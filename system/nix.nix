{pkgs, ...}: {
  # man configuration.nix / https://nixos.org/nixos/options.html
  system.stateVersion = "23.11";

  # https://github.com/Mic92/nix-ld
  programs.nix-ld.enable = true;

  nix = {
    checkConfig = true;
    checkAllErrors = true;

    gc.randomizedDelaySec = "10m";

    # https://discourse.nixos.org/t/issue-building-linux-kernel-modules-after-flake-update/62322/15
    package = pkgs.nixVersions.latest;
    settings = {
      auto-optimise-store = true;

      allowed-users = ["@wheel"];
      trusted-users = [
        "root"
        "@wheel"
      ];

      substituters = [
        "https://cache.nixos.org"
        "https://cache.garnix.io"
      ];

      trusted-substituters = [
        "https://cache.nixos.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];

      extra-experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
  ];
}
