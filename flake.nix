{
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
        musnix  = { url = "github:musnix/musnix"; };
        
		nur.url = "github:nix-community/NUR";
	};

	outputs = { nixpkgs, nixpkgs-stable, nixpkgs-unstable, home-manager, nur, musnix, ... }:
		let
			system = "x86_64-linux";

			nixosCustomSystem = { modules }: nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = {
					inherit nixpkgs-stable nixpkgs-unstable musnix;
					pkgs-stable = nixpkgs-stable.legacyPackages.${system};
					pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

					systemPath = ./system;
					userPath = ./user;
					law = import ./system/law.nix rec {
						pkgs = nixpkgs.legacyPackages.x86_64-linux;
						lib = pkgs.lib;
					};

					nur-modules = import nur {
						nurpkgs = nixpkgs.legacyPackages.x86_64-linux;
						pkgs = nixpkgs.legacyPackages.x86_64-linux;
					};
				};

				modules = modules ++ [
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = false;
						home-manager.useUserPackages = true;
					}

					./system/global.nix
					musnix.nixosModules.musnix
					nur.nixosModules.nur
				];
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
