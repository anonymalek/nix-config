
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./galactia-hw.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

}

