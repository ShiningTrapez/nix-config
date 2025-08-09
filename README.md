<h1 align="center"></h1>
<div align="center">

# NixOS Config

[![License: CC0-1.0](https://licensebuttons.net/l/zero/1.0/80x15.png)](http://creativecommons.org/publicdomain/zero/1.0/)

</div>

## Use
```bash
# Update Flake Inputs
$ nix flake update .

# Rebuild System
$ sudo nixos-rebuild switch --impure --flake .
# Or
$ nixos apply .
# Or
$ nixos rebuild

# Format
$ nix fmt
```
