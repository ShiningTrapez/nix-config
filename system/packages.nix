{pkgs, ...}: {
  hardware.opentabletdriver.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11" # Logseq
  ];

  # TODO: A lot of these could be moved to Home Manager
  environment.systemPackages = with pkgs; [
    glibcLocales # https://github.com/NixOS/nixpkgs/issues/8398#issuecomment-186832814

    appimage-run
    imagemagick
    vlc
    curl
    gcc
    dunst
    openssl
    seahorse # GUI for Gnome Keyring
    # gnome.cheese
    fnm
    atuin
    starship
    macchina
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
    webcamoid

    libreoffice-qt
    hunspell
    hunspellDicts.en_GB-large
    corefonts

    logseq

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

    pavucontrol

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

    # Sound
    pavucontrol
    pipewire

    # gimp-with-plugins

    # Needed for some GTK Apps
    adwaita-icon-theme

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

  # Make App Images directly executable
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
}
