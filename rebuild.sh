#!/bin/sh

sudo nixos-rebuild switch --flake .#$HOSTNAME $@
