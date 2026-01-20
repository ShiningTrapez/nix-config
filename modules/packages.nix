{pkgs, ...}: {
  programs.jq.enable = true;

  home.packages = with pkgs; [
    bat
    gimp-with-plugins
    blender
    steam-acf
    webcamoid
    ungoogled-chromium
    firefox-beta
    protonup-qt
    protontricks
    heroic

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
    zip

    libreoffice-qt
    hunspell
    hunspellDicts.en_GB-large

    texlive.combined.scheme-full
    prismlauncher
    # jetbrains.idea-oss
    jetbrains-toolbox

    discord-ptb # Discord
    vesktop # Discord Alt Client
    slack
    teams-for-linux
    vscode

    # Screenshots
    grim
    slurp
    swappy

    scrcpy
    androidenv.androidPkgs.platform-tools

    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio-fuse
    kdePackages.kio-extras
  ];
}
