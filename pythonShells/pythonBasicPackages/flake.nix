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
    myPython313Packages = pkgs.python313Packages // {
      jupyterlab-vim = pkgs.python313.pkgs.buildPythonPackage rec {
        pname = "jupyterlab-vim";
        version = "4.1.4";
        src = pkgs.fetchurl {
          url = "https://files.pythonhosted.org/packages/17/d8/3ff5da56fc66a7b751925810c4e4b6a888c8b1e7a7c53b38e5492d1357fd/jupyterlab_vim-4.1.4.tar.gz";
          sha256 = "0ni2hl5sbh39sn08vlr3wnmhrgmwgsp230yr9awhqbxkmwd8kwmb";
        };
        pyproject = true;
        nativeBuildInputs = [
          pkgs.python313.pkgs.setuptools
          pkgs.python313.pkgs.setuptools_scm
          pkgs.python313.pkgs.hatchling
          pkgs.python313.pkgs.hatch-jupyter-builder
          pkgs.python313.pkgs.hatch-nodejs-version
        ];
        propagatedBuildInputs = [
          pkgs.python313.pkgs.jupyterlab
        ];
      };
    };

  in
  {
    lib.pythonPackages = with myPython313Packages; [
      jupyter
      jupyterlab
      jupyterlab-vim
      jaraco-context
      ipykernel
      ipython
      pikepdf


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
