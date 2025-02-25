{ ... }: 

{
  # man configuration.nix / https://nixos.org/nixos/options.html
  system.stateVersion = "23.11";

  # https://github.com/Mic92/nix-ld
  programs.nix-ld.enable = true;

  nix = {
    # gc.automatic = true;

    settings = {
      auto-optimise-store = true;

      allowed-users = ["@wheel"];
      trusted-users = ["root" "@wheel"];

      # https://nix.dev/manual/nix/2.25/command-ref/conf-file.html#conf-download-buffer-size
      # download-buffer-size = 256000000;

      substituters = [
        "https://cache.nixos.org"
      ];

      trusted-substituters = [
        "https://cache.nixos.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];

      experimental-features = "nix-command flakes";
    };
  };
}