{ lib, pkgs, ... }:
{
	firejailWrapSys = wrappedBinaries: wrappedBinaries;

	firejailWrapPkgs = (wrappedBinaries:
		lib.attrsets.mapAttrsToList (name: value:
			(lib.attrsets.mergeAttrsList [ (pkgs.writeShellScriptBin name
			''firejail ${value.executable}
				--profile=${value.profile}
				${lib.concatStrings (lib.lists.forEach value.extraArgs (arg: " ${arg} "))}
				-- $@
			'') { meta.priority = -3; } ])
		) wrappedBinaries);
}
