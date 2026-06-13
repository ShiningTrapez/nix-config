{
  inputs,
  pkgs,
  ...
}: {
  programs.jq.enable = true;

  home.packages = with pkgs; [
    bat

    # https://discourse.nixos.org/t/how-to-fix-evaluation-warning-system-has-been-renamed-to-replaced-by-stdenv-hostplatform-system/72120
    inputs.nix-photogimp.packages.${stdenv.hostPlatform.system}.default
    blender
    inkscape-with-extensions
    freecad-wayland
    steam-acf
    webcamoid
    google-chrome
    firefox-beta
    protonup-qt
    protontricks
    # heroic
    freetube
    qbittorrent

    kubectl

    imagemagick
    vlc
    curl
    gcc
    dunst
    openssl
    seahorse # GUI for Gnome Keyring

    fnm
    macchina
    onefetch
    lolcat
    flameshot
    unzip
    nixd
    niv
    comma
    nix-init
    zip

    libreoffice-qt
    hunspell
    hunspellDicts.en_GB-large

    texlive.combined.scheme-full
    prismlauncher

    # openssl-1.1.1w marked insecure
    # discord-ptb # Discord
    vesktop # Discord Alt Client
    slack
    teams-for-linux
    vscode

    # Screenshots
    grim
    slurp
    swappy

    scrcpy
    android-tools

    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio-fuse
    kdePackages.kio-extras
  ];
}
