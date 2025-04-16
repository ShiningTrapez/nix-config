{ pkgs, ... }: let
  # echo | openssl s_client -connect '1.1.1.1:853' 2>/dev/null \
  # | openssl x509 -pubkey -noout \
  # | openssl pkey -pubin -outform der \
  # | openssl dgst -sha256 -binary \
  # | openssl enc -base64
  digest = "SPfg6FluPIlUc6a5h313BDCxQYNGX+THTy7ig5X3+VA=";
in {
  networking = {
    hostName = "RainbowMachine";
    nameservers = [ "127.0.0.1" "::1" ];

    firewall.allowedTCPPorts = [
      25565 # Minecraft
    ];

    networkmanager = {
      enable = true;
      dns = "none";
      wifi.backend = "iwd";
    };

    wireless.iwd.settings = {
      IPv6 = {
        Enabled = true;
      };
      Settings = {
        AutoConnect = true;
        ControlPortOverNL80211 = false;
      };
    };

    extraHosts = ''
      127.0.0.1 www.sandbox.bbctvapps.co.uk
    '';
  };

  services.stubby = {
    enable = true;
    settings = pkgs.stubby.passthru.settingsExample // {
      upstream_recursive_servers = [{
        address_data = "1.1.1.1";
        tls_auth_name = "cloudflare-dns.com";
        tls_pubkey_pinset = [{
          digest = "sha256";
          value = digest;
        }];
      } {
        address_data = "1.0.0.1";
        tls_auth_name = "cloudflare-dns.com";
        tls_pubkey_pinset = [{
          digest = "sha256";
          value = digest;
        }];
      }];
    };
  };
}
