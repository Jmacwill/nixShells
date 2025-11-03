{
  description = "Project flake combining python core and package collections";

  inputs = {
    pythonCore.url = "github:cmacwill1/nixShells?dir=pythonCore";
    pythonPackages.url = "github:cmacwill1/nixShells?dir=pythonBasicPackages";
    nixpkgs.follow = "pythonCore";
  };

  outputs = { self, inputs, nixpkgs, }:
  let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
    python = inputs.pythonCore.packages.${system}.default;

    allPythonPackages = inputs.pythonPackages.lib.pythonPackages;
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        (python.withPackages (_: allPythonPackages))
      ];
    };
  };
}
