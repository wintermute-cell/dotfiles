{
  description = "home manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { nixpkgs, home-manager, nur, ... }:
  let
    system = "x86_64-linux";
    user = "winterveil";
  in {
    packages.${system}.default = home-manager.defaultPackage.${system};
    homeConfigurations = {
      "winterveil" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nur.overlay ];
        };
        modules = [
          ./home-manager/home.nix
          {
            home = {
              homeDirectory = "/home/${user}";
              username = "${user}";
              stateVersion = "23.11";
            };
          }
          {
            nixpkgs = {
              config = {
                allowUnfree = true;
              };
            };
          }
        ];
      };
    };
  };
}
