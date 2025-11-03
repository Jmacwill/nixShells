{
  description = "Project flake combining python core and package collections";

  inputs = {
    pythonCore.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonCore";
    pythonBasicPackages.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonBasicPackages";
    pythonNotebook.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonNotebook";
    pythonAbaqus.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonAbaqus";
    latexMain.url = "github:cmacwill1/nixShells?dir=latexShells/latexMain";
    nixpkgs.follows = "pythonCore/nixpkgs";
  };

  outputs = { self, pythonCore, pythonBasicPackages, pythonNotebook, pythonAbaqus, latexMain, nixpkgs }:
  let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
    python = pythonCore.packages.${system}.default;
    latex = latexMain.packages.${system}.default;

    allPythonPackages = pythonBasicPackages.lib.pythonPackages
                        ++ pythonNotebook.lib.pythonPackages
                        ++ pythonAbaqus.lib.pythonPackages;
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
