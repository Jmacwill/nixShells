{
  description = "Project flake combining python core and package collections";

  inputs = {
    pythonCore.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonCore";
    pythonPackages.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonBasicPackages";
    latexMain.url = "github:cmacwill1/nixShells?dir=latexShells/latexMain";
    nixpkgs.follows = "pythonCore/nixpkgs";
  };

  outputs = { self, pythonCore, pythonPackages, latexMain, nixpkgs }:
  let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
    python = pythonCore.packages.${system}.default;
    latex = latexMain.packages.${system}.default;

    allPythonPackages = pythonPackages.lib.pythonPackages;
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        (python.withPackages (pythonPkgs: allPythonPackages))
        latex
      ];
    };
  };
}
