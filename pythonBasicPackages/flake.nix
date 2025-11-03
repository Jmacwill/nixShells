{
  description = "A very basic flake";

  inputs = {
    pythonCore.url = "github:cmacwill1/nixShells?dir=pythonCore";
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      inputs.nixpkgs.follows = "pythonCore";
    };
  };

  outputs = { self, pythonCore, nixpkgs}:
  let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in
  {
    lib.pythonPackages = with pkgs.python313Packages; [
      numpy
    ];
  };
}
