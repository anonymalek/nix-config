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

		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};
        
		nur.url = "github:nix-community/NUR";
	};

	outputs = { nixpkgs, nixpkgs-stable, nixpkgs-unstable, home-manager, nur, musnix, nixvim, ... }:
		let
			system = "x86_64-linux";

			nixosCustomSystem = { modules }: nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = rec {
					inherit nixpkgs-stable nixpkgs-unstable musnix nixvim;
					pkgs-stable = nixpkgs-stable.legacyPackages.${system};
					pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

					systemPath = ./system;
					userPath = ./user;

					nur-modules = import nur {
						nurpkgs = nixpkgs.legacyPackages.x86_64-linux;
						pkgs = nixpkgs.legacyPackages.x86_64-linux;
					};
				};

				modules = modules ++ [
					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = false;
						home-manager.useUserPackages = false;
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

			galactia = nixosCustomSystem {
				modules = [ ./user/trigo/hardware/galactia.nix ./user/trigo/profile.nix ./user/alek/profile.nix];
			};

      hologramsummeragain = nixosCustomSystem {
        modules = [ ./user/malwareskunk/hardware/hologramsummeragain.nix ./user/malwareskunk/profile.nix ];
      };
		};
	};
}
