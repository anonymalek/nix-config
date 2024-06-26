args@{ lib, pkgs, systemPath ? ./., ... }:
rec {
	makeSystemUserModule = user: lib.attrsets.mergeAttrsList [
		(makeSystemModule user.profiles)
		(makeUserModule user)
	];

	makeSystemModule = profiles: {
		allowedUnfree = listFromProfiles (importProfilesById profiles) "allowedUnfree";
		environment.systemPackages = listFromProfiles (importProfilesById profiles) "packages";

		imports = lib.lists.forEach (importProfilesById profiles) (profile: profile.sys);
	};

	makeUserModule = user: {
		allowedUnfree = listFromProfiles (importProfilesById user.profiles) "allowedUnfree";

		users.users.${user.username} = lib.attrsets.mergeAttrsList [
			user.user
			{
				extraGroups = (readUser user.user).extraGroups
					++ (listFromProfiles (importProfilesById user.profiles) "groups");
				
				packages = (readUser user.user).packages
					++ (listFromProfiles (importProfilesById user.profiles) "packages");
			}
		];

		home-manager.users.${user.username} = {
			imports =
				[user.home] ++
				lib.lists.forEach (importProfilesById user.profiles) (profile: profile.home);
		};
	};

	importProfileNonRecursively = profilePath: (lib.attrsets.mergeAttrsList [
		{
			# Defaults
			imports = [ ];
			sys = { };
			home = { };
			packages = [ ];
			allowedUnfree = [ ];
			groups = [ ];
		}

		(import profilePath {
			inherit pkgs lib systemPath firejailWrap;
		})
	]);

	importProfile = (profilePath:
		[ (importProfileNonRecursively profilePath) ]
		++ ( lib.concatLists
			(lib.lists.forEach (importProfileNonRecursively profilePath).imports
				(subprofilePath: importProfile subprofilePath)
			)
		)
	);

	importProfileById = profileId:
		importProfile (profileIdToPath profileId);

	importProfilesById = profileIds: (lib.concatLists
		(
			lib.lists.forEach profileIds
				(profileId: importProfileById profileId)
		)
	);

	profileIdToPath = profileId:
		(systemPath + "/profiles" + profileId + ".nix");

	readUser = user: (lib.attrsets.mergeAttrsList [
		{
			packages = [ ];
		}

		user
	]);

	listFromProfiles = profiles: valueName: lib.concatLists (
		lib.lists.forEach profiles
			(profile: profile.${valueName})
	);

	firejailWrap = {
		system = wrappedBinaries: wrappedBinaries;

		packages = (wrappedBinaries:
			lib.attrsets.mapAttrsToList (name: value:
				(lib.attrsets.mergeAttrsList [ (pkgs.writeShellScriptBin name
				''firejail \
					${if (lib.attrsets.hasAttrByPath [ "profile" ] value) then
						"--profile=${value.profile}"
					else ""
					}\
					${if (lib.attrsets.hasAttrByPath [ "extraArgs" ] value) then
						(lib.concatStrings (lib.lists.forEach value.extraArgs (arg: arg + " ")))
					else ""
					}\
					-- ${value.executable} $@
				'') { meta.priority = -3; } ])
			) wrappedBinaries);
	};
}
