{
  description = "Provides abqpy override package for python dev shells";

  inputs = {
    pythonCore.url = "github:cmacwill1/nixShells?dir=pythonShells/pythonCore";
    nixpkgs.follows = "pythonCore/nixpkgs";
  };

  outputs = { self, pythonCore, nixpkgs}:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    myPython313Packages = pkgs.python313Packages // {
      auto-all = pkgs.python313.pkgs.buildPythonPackage rec {
        pname = "auto-all";
        version = "1.4.1";
        src = pkgs.fetchurl {
          url = "https://files.pythonhosted.org/packages/cf/ae/1317a5362e0016be1efb445b77b98cfddc41f87ae95492da5b43e6537a07/auto_all-1.4.1-py2.py3-none-any.whl";
          sha256 = "04zfkq7nh0khfxw91qiszpgk3hiywch5x6525mzci50fcwmf1nj8";
        };
        format = "wheel";
        doCheck = false;
        buildInputs = [];
        checkInputs = [];
        nativeBuildInputs = [];
        propagatedBuildInputs = [];
      };
      abqpy = pkgs.python313.pkgs.buildPythonPackage rec {
        pname = "abqpy";
        version = "2024.9";
        src = pkgs.fetchurl {
          url = "https://files.pythonhosted.org/packages/e4/34/b5a4f2f4aa62fc4376ba26fbdca1cd6fffabf355bbed6f4cb6795014271b/abqpy-2024.9.tar.gz";
          sha256 = "sha256-hRwfXPwh20Uz6K8zGNYjg67YzhOGjfMPQezzk/EfqFA=";
        };
        pyproject = true;
        nativeBuildInputs = with pkgs.python313.pkgs; [
          setuptools
          setuptools-scm
          wheel
        ];
        propagatedBuildInputs = with pkgs.python313.pkgs; [
          self.auto-all
          fire
          pydantic
          typeguard
          typing-extensions
        ];
      };
    };

  in
  {
    lib.pythonPackages = with myPython313Packages; [
      abqpy
    ];
  };
}
