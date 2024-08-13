{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    nodejs_22
    nodePackages.npm
    nodePackages.yarn
    pnpm
  ];
}
