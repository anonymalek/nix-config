{
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
		
		nypkgs = {
            url = "github:yunfachi/nypkgs";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        musnix  = { url = "github:musnix/musnix"; };
        
		nur.url = "github:nix-community/NUR";
	};

	outputs = inputs@{ nixpkgs, nur, nixpkgs-stable, nixpkgs-unstable, nypkgs, musnix, ... }:
		let
			system = "x86_64-linux";

			nixosCustomSystem = { modules }: nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = {
					inherit nixpkgs-stable;
					inherit nixpkgs-unstable;
					inherit system;
					inherit nypkgs;
					inherit musnix;
					
					master = { ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODtyJdBnjtc6yXraTaj2Y8PZtx2EuU/gXdUsG2cd4Ng niki@pandora"; };
				};

				

				modules = modules ++ [ ./system/global.nix ] ++ [ inputs.musnix.nixosModules.musnix ]
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
				modules = [ ./user/niki/hardware/pandora.nix ./user/niki/profile.nix ];
			};

			neopax = nixosCustomSystem {
				modules = [ ./user/niki/hardware/neopax.nix ./user/niki/profile.nix ];
			};

			termina = nixosCustomSystem {
				modules = [ ./user/alek/hardware/termina.nix ./user/alek/profile.nix ];
			};
		};
	};
}
