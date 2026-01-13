{
  config,
  pkgs,
  lib,
  osFlakePath,
  ...
}: let
  projects = "${config.home.homeDirectory}/Projects";
  work = "${config.home.homeDirectory}/Work";
  work-cert = "${config.home.homeDirectory}/morrip87.pem";
in {
  home.sessionVariables = {
    EDITOR = "code --wait";
    BBC_CERT_PATH = "${work-cert}";
    CLIENT_CERT = "${work-cert}";
    # _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";

    # https://github.com/tauri-apps/tauri/issues/9304#issuecomment-2028409103
    WEBKIT_DISABLE_DMABUF_RENDERER = 1;

    # https://github.com/NixOS/nixpkgs/issues/8398#issuecomment-251287741
    LANG = "en_GB.UTF-8";
    LC_ALL = "en_GB.UTF-8";

    # Puppeteer is awkward on Nix
    PUPPETEER_SKIP_DOWNLOAD = 1;
  };

  programs.zsh = {
    enable = true;
    autocd = true;

    cdpath = [
      "${projects}"
      "${projects}/Minecraft"
      "${work}"
      "${work}/tv-client/packages"
      "${work}/tv-client/apps"
      "${config.xdg.configHome}"
    ];

    dotDir = "${config.xdg.configHome}/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;

    shellAliases = {
      restart = "shutdown -r now";
      syntax = "bat";
      temperature = "echo $(( $(cat /sys/class/thermal/thermal_zone*/temp) / 1000 )) | sed 's/$/C/'";
      gpu-temperature = "nvidia-smi --query-gpu=temperature.gpu --format csv | tail -n1 | sed 's/$/C/'";
      system-temperature = "echo -e \"\\033[0;31mCPU: $(temperature)\\033[0m\n\\033[0;32mGPU: $(gpu-temperature)\\033[0m\"";
      gpu-info = "nvidia-smi --query-gpu=timestamp,name,temperature.gpu,utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv -l 5";

      reload = "source ${config.xdg.configHome}/zsh/.zshrc";
      system-config = "code --wait ${osFlakePath}";
      system-update-flake = "nix flake update --flake ${osFlakePath}";
      system-rebuild = "sudo nixos-rebuild switch --impure --flake ${osFlakePath} && reload";
      system-rebuild-offline = "sudo nixos-rebuild switch --offline --impure --flake ${osFlakePath} && reload";
      system-upgrade = "system-update-flake && system-rebuild && system-clean";
      clean = "nix-collect-garbage -d";
      system-clean = "sudo clean-generations 2 0 system && clean";

      tree = "lt";
      fix-audio = "systemctl --user restart pipewire.service";
      fix-internet = "sudo systemctl restart NetworkManager";
      back = "cd $OLD_PWD";
      work = "cd ${work}";
      projects = "cd ${projects}";

      g = "git";
      ga = "git add";
      gaa = "git add -A";
      gb = "git branch";
      gc = "git commit";
      gf = "git fetch";
      gp = "git push";
      gpf = "git push --force-with-lease";
      gpu = "git pull";
      gs = "git status";

      phone = "scrcpy --video-codec=h265 -m1920 --max-fps=60 --no-audio -K &";

      # Workaround for non FHS Patched Binaries installed by FNM
      # TODO: Use nix-ld
      npm = "steam-run npm";
      pnpm = "steam-run pnpm";
      yarn = "steam-run yarn";
      node = "steam-run node";
      corepack = "steam-run corepack";
    };

    plugins = with pkgs; [
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-you-should-use";
        src = fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-you-should-use";
          rev = "1.10.0";
          sha256 = "sha256-dG6E6cOKu2ZvtkwxMXx/op3rbevT1QSOQTgw//7GmSk=";
        };
        file = "you-should-use.plugin.zsh";
      }
      {
        name = "zsh-autoquoter";
        src = fetchFromGitHub {
          owner = "ianthehenry";
          repo = "zsh-autoquoter";
          rev = "9e3b1b216bf7b61a9807a242bae730b5fc232a44";
          sha256 = "sha256-CdyKIGxOnWGWPeBuNz067zp8/a394H0Ec2h3CA3oIx0=";
        };
        file = "zsh-autoquoter.zsh";
      }
    ];

    initContent = lib.mkAfter (builtins.readFile ./init.zsh);
  };

  home.file."${config.home.homeDirectory}/.config/zsh/scripts/" = {
    source = ./scripts;
    recursive = true;
  };
}
