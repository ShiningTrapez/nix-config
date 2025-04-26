{ config, lib, ...}: let
    before = lib.hm.dag.entryBefore;
  in {
    programs.ssh = {
    enable = true;
    matchBlocks = {
      "github gh github.com gitlab gl gitlab.com" = before [
        "github gh github.com"
        "gitlab gl gitlab.com"
      ] {
        user = "git";
        identitiesOnly = true;

        extraOptions = {
          requestTTY = "no";
        };
      };

      "github gh github.com" = {
        hostname = "github.com";
        identityFile = "${config.home.homeDirectory}/.ssh/id_github";
      };

      "gitlab gl gitlab.com" = {
        hostname = "gitlab.com";
        identityFile = "${config.home.homeDirectory}/.ssh/id_gitlab";
      };

      "machine.church machine" = {
        user = "sophia";
        hostname = "machine.church";
        identityFile = "${config.home.homeDirectory}/.ssh/id_hetzner";
        addressFamily = "inet"; # Use IPv4
      };

      # BBC EC2
      "?.access.*.cloud.bbc.co.uk" = {
        identityFile = "${config.home.homeDirectory}/.ssh/id_rsa";
        proxyCommand = "nc -x socks-gw.reith.bbc.co.uk:1085 -X 5 %h %p";
      };

      "*,??-*-?" = {
        user = "peter_morris_hind";
        identityFile = "${config.home.homeDirectory}/.ssh/id_rsa";
        proxyCommand = ">&1; IFS=,. read -r a b c d r <<<\"%h\"; exec ssh -q -p 22000 bastion-tunnel@$((b / 32)).access.$r.cloud.bbc.co.uk nc $a.$b.$c.$d %p";
        extraOptions = {
          strictHostKeyChecking = "no";
          userKnownHostsFile = "/dev/null";
        };
      };
    };
  };
}
