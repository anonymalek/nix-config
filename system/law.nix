args@{ lib, pkgs, systemPath ? ./., ... }:
rec {
	makeSystemUserModule = user: lib.attrsets.mergeAttrsList [
		(makeSystemModule user.profiles)
		(makeUserModule user)
	];

	makeSystemModule = profiles: {
		allowedUnfree = unfreeListFromProfiles profiles;
		imports = (lib.attrsets.mergeAttrsList [
			(lib.lists.map (profileId: (importProfile profileId).sys) profiles)
		]) ++ [{
			environment.systemPackages = (
				lib.concatLists (
					lib.lists.map (profileId: (importProfile profileId).packages) profiles
				)
			);
		}];
	};

	makeUserModule = user: {
		allowedUnfree = unfreeListFromProfiles user.profiles;
		users.users.${user.username} = lib.attrsets.mergeAttrsList [
			user.user
			{
				extraGroups = (lib.concatLists (lib.lists.map
					(profileId: (importProfile profileId).groups)
					user.profiles
				)) ++ (readUser user.user).extraGroups;

				packages = (lib.concatLists (lib.lists.map
					(profileId: (importProfile profileId).packages)
					user.profiles
				)) ++ (readUser user.user).packages;
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
			imports = [ ];
			sys = { };
			home = { };
			packages = [ ];
			allowedUnfree = [ ];
			groups = [ ];
		}

		(import (systemPath + "/profiles" + profileId + ".nix") {
			inherit pkgs lib systemPath firejailWrap;
		})
	]);

	readUser = user: (lib.attrsets.mergeAttrsList [
		{
			packages = [ ];
		}

		user
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
					${if (lib.attrsets.hasAttrByPath [ "profile" ] value) then
						"--profile=${value.profile}"
					else ""
					}

					${if (lib.attrsets.hasAttrByPath [ "extraArgs" ] value) then
						(lib.concatStrings (lib.lists.forEach value.extraArgs (arg: arg + " ")))
					else ""
					}
					-- $@
				'') { meta.priority = -3; } ])
			) wrappedBinaries);
	};
}
