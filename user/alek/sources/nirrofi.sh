#!/bin/sh

NIXPKGS_ALLOW_UNFREE=1 nix run nixpkgs#$(cat /home/alek/playground/law/nix-config/user/alek/sources/pkg-list | rofi -dmenu)
