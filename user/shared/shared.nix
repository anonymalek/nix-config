{ pkgs, ... }:
{
	imports = [ ./tf2.nix ];
	
	home.file.".gnupg/gpg-agent.conf".text = "pinentry-program /run/current-system/sw/bin/pinentry";
}
