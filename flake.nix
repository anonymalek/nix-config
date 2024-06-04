{
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
		
		nypkgs = {
            url = "github:yunfachi/nypkgs";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
		nur.url = "github:nix-community/NUR";
	};

	outputs = inputs@{ nixpkgs, nur, nixpkgs-stable, nixpkgs-unstable, nypkgs, ... }:
		let
			system = "x86_64-linux";

			nixosCustomSystem = { modules }: nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = {
					inherit nixpkgs-stable;
					inherit nixpkgs-unstable;
					inherit system;
					inherit nypkgs;
					
					master = { ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODtyJdBnjtc6yXraTaj2Y8PZtx2EuU/gXdUsG2cd4Ng niki@pandora"; };
				};

				

				modules = modules ++ [ ./system/global.nix ]	
				++ (let nur-modules = import nur rec {
					nurpkgs = nixpkgs.legacyPackages.x86_64-linux;
					pkgs = nixpkgs.legacyPackages.x86_64-linux;
				};
				in [
					nur.nixosModules.nur
					nur-modules.repos.LuisChDev.modules.nordvpn
				]);
			};
		in {
		nixosConfigurations = {
			pandora = nixosCustomSystem {
				modules = [ ./system/pandora.nix ./system/profiles/niki.nix ];
			};

			neopax = nixosCustomSystem {
				modules = [ ./system/neopax.nix ./system/profiles/niki.nix ];
			};

			termina = nixosCustomSystem {
				modules = [ ./user/alek/hardware/termina.nix ./user/alek/profile.nix ];
			};
		};
	};
}