{

  # ===========================================================================
  # On first install, this flake needs to run to install home-manager:
  #     `nix run . -- build --flake .`
  #
  # Then activate the configuration with:
  #     `nix run . -- switch --flake $HOME'/dotfiles?submodules=1';`
  #
  # Since the home-manager config should specify 
  #     `programs.home-mnager.enable = true`
  # this should make the `home-manager` command available.
  #
  # From then on, use this to activate the configuration:
  #     `home-manager switch --flake $HOME'/dotfiles?submodules=1';`
  #
  # (instead of the dot as the flake path, a full path can be specified ofc)
  # ===========================================================================

  description = "home manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nur, ... }:
  let
    system = "x86_64-linux";
    winterveil = "winterveil";
    work = "work";
    pkgs = import nixpkgs {
        inherit system;
        overlays = [ 
          nur.overlays.default
          (final: _prev: { # overlays are functions that take two arguments, the final set and the previous set.
            unstable = import nixpkgs-unstable {
              inherit (final) system config;
            };
          })
          (final: prev: { # fix for manix not working with flake based home manager. see: https://github.com/nix-community/manix/issues/18
            manix = prev.manix.override (old: {
              rustPlatform = old.rustPlatform // {
                buildRustPackage = args:
                  old.rustPlatform.buildRustPackage (args // {
                    version = "0.8.0-pr20";
                    src = prev.fetchFromGitHub {
                      owner = "nix-community";
                      repo = "manix";
                      rev = "c532d14b0b59d92c4fab156fc8acd0565a0836af";
                      sha256 = "sha256-Uo+4/be6rT0W8Z1dvCRXOANvoct6gJ4714flhyFzmKU=";
                    };
                    cargoHash = "sha256-FTrKdOuXTOqr7on4RzYl/UxgUJqh+Rk3KJXqsW0fuo0=";
                  });
              };
            });
          })
        ];
      };
  in {
    packages.${system}.default = home-manager.defaultPackage.${system};
    homeConfigurations.${winterveil} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home-manager/base.nix
        ./home-manager/winterveil.nix
        {
          home = {
            homeDirectory = "/home/${winterveil}";
            username = "${winterveil}";
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
    homeConfigurations.${work} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home-manager/base.nix
        ./home-manager/work.nix
        {
          home = {
            homeDirectory = "/home/${work}";
            username = "${work}";
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
}
