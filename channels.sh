#!/bin/sh

sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --add https://github.com/musnix/musnix/archive/master.tar.gz musnix
sudo nix-channel --update
