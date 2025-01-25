{
  description = "Evan's Mac{book, Mini} flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nix-darwin, nixpkgs, nix-homebrew, home-manager, homebrew-core, homebrew-cask, homebrew-bundle, ... }@inputs: {
    darwinConfigurations."xarpus" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager

        ./common.nix
        ./xarpus.nix
      ];
    };
  };
}