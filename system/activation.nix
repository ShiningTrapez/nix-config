{ ... }:

{
  # Link Bash to /bin/bash
  system.activationScripts.binbash = {
    deps = [ "binsh" ];
    text = ''
      ln -fs /bin/sh /bin/bash
    '';
  };
}