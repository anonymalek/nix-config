{
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
	};

	outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixpkgs-unstable, ... }:
		let
			system = "x86_64-linux";

			nixosCustomSystem = { modules }: nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = {
					inherit nixpkgs-stable;
					inherit nixpkgs-unstable;
					inherit system;
					master = {
						ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODtyJdBnjtc6yXraTaj2Y8PZtx2EuU/gXdUsG2cd4Ng niki@pandora";
					};
				};

				inherit modules;
			};
		in {
		nixosConfigurations = {
			pandora = nixosCustomSystem {
			};

			neopax = nixosCustomSystem {
			};

			termina = nixosCustomSystem {
				modules = [ ./system/termina.nix ./system/profiles/alek.nix ];
			};
		};
	};
}
