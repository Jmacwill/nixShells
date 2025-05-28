{
  description = "Dev shell for simple python engineering code";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    python = pkgs.python312;
  in
  {
    devShells."x86_64-linux".default = pkgs.mkShell {
      shellHook = ''
	echo "Welcome to the pythonEngr shell test";
      '';

      packages = [
        (python.withPackages (python-pkgs: with python-pkgs; [
	  # notebook
          jupyter
          jupyterlab
          ipykernel
          ipython

          # scientific computing
          pandas # Data structures & tools
	  openpyxl # Python excel stuff
          sympy # Symbolic math
          numpy # Array & matrices
          scipy # Integral, solving differential, equations, optimizations)

          # Visualization
          matplotlib # plot & graphs
          seaborn # heat maps, time series, violin plot
        ]))
      ];
    };
  };
}
