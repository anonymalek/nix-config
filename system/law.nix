args@{ lib, pkgs, systemPath ? ./., ... }:
rec {
	makeSystemUserModule = user: lib.attrsets.mergeAttrsList [
		(makeSystemModule user.profiles)
		(makeUserModule user)
	];

	makeSystemModule = profiles: {
		allowedUnfree = unfreeListFromProfiles profiles;
		imports = lib.attrsets.mergeAttrsList [
			(lib.lists.map (profileId: (importProfile profileId).sys) profiles)
		];
	};

	makeUserModule = user: {
		allowedUnfree = unfreeListFromProfiles user.profiles;
		users.users.${user.username} = lib.attrsets.mergeAttrsList [
			user.user
			{
				extraGroups = (lib.concatLists (lib.lists.map
					(profileId: (importProfile profileId).groups)
					user.profiles
				)) ++ user.user.extraGroups;
			}
		];

		home-manager.users.${user.username} = {
			imports = (
				[user.home] ++
				(lib.lists.map (profileId: (importProfile profileId).home) user.profiles)
			);
		};
	};

	importProfile = profileId: (lib.attrsets.mergeAttrsList [
		{
			# Defaults
			allowedUnfree = [ ];
			groups = [ ];
			sys = { };
			home = { };
		}

		(import (systemPath + "/profiles" + profileId + ".nix") {
			inherit pkgs lib systemPath firejailWrap;
		})
	]);

	unfreeListFromProfiles = profiles: lib.concatLists (
		lib.lists.forEach profiles
		(profileId: (importProfile profileId).allowedUnfree)
	);

	firejailWrap = {
		system = wrappedBinaries: wrappedBinaries;

		packages = (wrappedBinaries:
			lib.attrsets.mapAttrsToList (name: value:
				(lib.attrsets.mergeAttrsList [ (pkgs.writeShellScriptBin name
				''firejail ${value.executable}
					--profile=${value.profile}
					${lib.concatStrings (lib.lists.forEach value.extraArgs (arg: " ${arg} "))}
					-- $@
				'') { meta.priority = -3; } ])
			) wrappedBinaries);
	};
}
