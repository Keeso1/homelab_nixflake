{
  description = "Isac's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, noctalia, zen-browser, ... }: {
    nixosConfigurations = {
      cyberhome = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit noctalia; };
        modules = [
          ./hosts/cyberhome/configuration.nix
        ];
      };

      cloudhome = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit noctalia zen-browser; };
        modules = [
          ./hosts/cloudhome/configuration.nix
        ];
      };
    };
  };
}
