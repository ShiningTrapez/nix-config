{
  pkgs,
  inputs,
  ...
}: let
  nixpkgs-24 = inputs.nixpkgs-24.legacyPackages.x86_64-linux;
in {
  programs.jq.enable = true;

  home.packages = with pkgs; [
    bat
    nixpkgs-24.gimp-with-plugins
    nixpkgs-24.blender
    steam-acf
    webcamoid
    ungoogled-chromium
    nur.repos.bandithedoge.waterfox-bin
    protonup-qt
    protontricks

    imagemagick
    vlc
    curl
    gcc
    dunst
    openssl
    seahorse # GUI for Gnome Keyring

    fnm
    atuin
    macchina
    onefetch
    lolcat
    # patchelf
    flameshot
    unzip
    nixd
    niv
    comma
    # devbox
    # warp-terminal
    # alacritty
    zip

    libreoffice-qt
    hunspell
    hunspellDicts.en_GB-large

    # haskellPackages.ghcup
    # rustup
    # jetbrains.rust-rover

    # LaTeX
    texlive.combined.scheme-full

    # Minecraft
    prismlauncher
    # jdk21

    # Podman
    # dive
    # podman-tui
    # podman-compose

    # networkmanagerapplet

    discord-ptb
    # (discord-ptb.override {
    # withOpenASAR = true;
    # withVencord = true;
    # })
    # vesktop # Discord Alt Client
    slack
    teams-for-linux
    # betterbird
    vscode
    # zed-editor
    # webex

    # Rust/Bevy (And possibly Minecraft?)
    # pkg-config
    # alsa-oss
    # udev
    # alsaLib
    # libGL
    # vulkan-loader

    # xorg.libX11
    # xorg.libXcursor
    # xorg.libXi
    # xorg.libXrandr
    # xorg.libXrender

    # gimp-with-plugins

    # Screenshots
    grim
    slurp
    swappy

    # Kotlin Dev
    # gradle
    # gradle-completion
    # jetbrains-toolbox
    # graalvm-ce
    # graalvmCEPackages.graaljs

    # Arcane Proxy
    # openssl.dev
    # gtk4.dev
    # pkg-config

    # Bricklink Studio
    # wineWowPackages.stable
    # winetricks
    # innoextract

    # Godot
    # godot_4
    # (with dotnetCorePackages; combinePackages [
    #   sdk_9_0
    #   # dotnet_9.runtime
    # ])
    # scons
    # pkg-config
    # (python3.withPackages (python-pkgs: [
    #   #
    # ]))

    # /etc/nixos/flake.nix
    # inputs.xencelabs.packages.xencelabs
  ];
}
