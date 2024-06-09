{
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
		
        musnix  = { url = "github:musnix/musnix"; };
        
		nur.url = "github:nix-community/NUR";
	};

	outputs = { nixpkgs, nixpkgs-stable, nixpkgs-unstable, nur, musnix, ... }:
		let
			system = "x86_64-linux";

			nixosCustomSystem = { modules }: nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = {
					inherit nixpkgs-stable nixpkgs-unstable musnix;

					systemPath = ./system;
					userPath = ./user;

					nur-modules = import nur {
						nurpkgs = nixpkgs.legacyPackages.x86_64-linux;
						pkgs = nixpkgs.legacyPackages.x86_64-linux;
					};
				};

				modules = modules ++ [
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
