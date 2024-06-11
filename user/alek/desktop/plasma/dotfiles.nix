{ lib, pkgs, config, ... }: 
let
	konsave-apply = (pkgs.writeShellScriptBin "konsave-apply" ''
		${pkgs.konsave}/bin/konsave -f -i "$1"
		${pkgs.konsave}/bin/konsave -a $(echo "$1" | sed -e 's/.*\///g' -e 's/.knsv//g')
	'');
in
{
	home.activation = {
		konsaveScript = lib.hm.dag.entryAfter ["writeBoundary"]
			''run ${konsave-apply}/bin/konsave-apply ${./alek.knsv}'';
	};
}
