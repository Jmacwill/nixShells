{
  description = "Project flake combining python core and package collections";

  inputs = {
    pythonCore.url = "github:cmacwill1/nixShells?dir=pythonCore";
    pythonPackages.url = "github:cmacwill1/nixShells?dir=pythonBasicPackages";
    pythonPackages2.url = "github:cmacwill1/nixShells?dir=pythonBasicPackages2";
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      inputs.nixpkgs.follows = "pythonCore";
    };
  };

  outputs = { self, nixpkgs, pythonCore, pythonPackages, pythonPackages2 }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    python = pythonCore.packages.${system}.default;

    # Combine both sets of package lists
    combinedPythonPackages = pythonPackages.lib.pythonPackages
                           ++ pythonPackages2.lib.pythonPackages;
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        (python.withPackages (_: combinedPythonPackages))
      ];
    };
  };
}
