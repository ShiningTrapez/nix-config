{ pkgs, ...}: {
  # man configuration.nix / https://nixos.org/nixos/options.html
  system.stateVersion = "23.11";

  # https://github.com/Mic92/nix-ld
  programs.nix-ld.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;

      allowed-users = ["@wheel"];
      trusted-users = [
        "root"
        "@wheel"
      ];

      experimental-features = "nix-command flakes";

      # https://github.com/NixOS/nix/issues/11728
      # download-buffer-size = 524288000;

      substituters = [
        "https://cache.nixos.org"
        "https://watersucks.cachix.org"
      ];

      trusted-substituters = [
        "https://cache.nixos.org"
        "https://watersucks.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
  ];

  services.nixos-cli = {
    enable = true;
    config = {
      # TODO: Parameterize nix-config location
      config_location = "/home/sophia/Projects/nix-config";
      apply = {
        use_nom = true;
        use_git_commit_msg = true;
      };
      aliases = {
        rebuild = ["apply" "-y"];
      };
    };
  };
}
