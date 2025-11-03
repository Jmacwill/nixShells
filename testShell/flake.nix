{
  description = "Project flake combining python core and package collections";

  inputs = {
    pythonCore.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonCore";
    pythonBasicPackages.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonBasicPackages";
    pythonNotebook.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonNotebook";
    pythonAbaqus.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonAbaqus";
    latexMain.url = "github:cmacwill1/nixShells?dir=latexShells/latexMain";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self,  nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
    python = inputs.pythonCore.packages.${system}.default;
    latex = inputs.latexMain.packages.${system}.default;

    allPythonPackages = inputs.pythonBasicPackages.lib.pythonPackages
                        ++ inputs.pythonNotebook.lib.pythonPackages
                        ++ inputs.pythonAbaqus.lib.pythonPackages;
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
