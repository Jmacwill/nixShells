{
  description = "Provides pythonPackages for dev shells";

  inputs = {
    pythonCore.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonCore";
    nixpkgs.follows = "pythonCore/nixpkgs";
  };

  outputs = { self, pythonCore, nixpkgs}:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    lib.pythonPackages = with pkgs.python313Packages; [
      numpy # Array & matrices
      pandas # Data structures & tools
      openpyxl # Python excel stuff
      sympy # Symbolic math
      scipy # Integral, solving differential, equations, optimizations)
      tabulate # tables
      matplotlib # plot & graphs
      seaborn # heat maps, time series, violin plot
    ];
  };
}
