{
  pkgs,
  osFlakePath,
  ...
}: {
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
    };
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
  ];

  services.nixos-cli = {
    enable = true;
    config = {
      config_location = osFlakePath;
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
