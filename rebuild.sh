#!/bin/sh

sudo nixos-rebuild switch --flake $(dirname $0)#$HOSTNAME $@
