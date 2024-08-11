#!/bin/sh

NIXPKGS_ALLOW_UNFREE=1 nix run nixpkgs#$(cat /conf/user/alek/sources/pkg-list | rofi -dmenu)
