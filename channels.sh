#!/bin/sh

sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --add https://github.com/musnix/musnix/archive/master.tar.gz musnix
sudo nix-channel --update
