{ lib, config, ... }: 
{
	home.activation = {
		konsaveScript = lib.hm.dag.entryAfter ["writeBoundary"] ''
		konsave -i ${./alek.knsv} && konsave -a alek'';
	};
}