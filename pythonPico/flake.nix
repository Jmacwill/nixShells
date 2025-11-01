{
  description = "Raspberry Pi Pico development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # MicroPython tools
            python3
            python3Packages.pip
            python3Packages.pyserial
            python3Packages.adafruit-ampy
            python3Packages.mpremote
            
            # Flashing and communication
            picotool
            minicom
            screen
            
            # Optional: if you want to build MicroPython from source
            # cmake
            # gcc-arm-embedded
            # ninja
          ];

          shellHook = ''
            echo "Raspberry Pi Pico MicroPython development environment loaded"
            echo ""
            echo "Available tools:"
            echo "  - mpremote (recommended: upload, run, and manage files)"
            echo "  - ampy (alternative: file management)"
            echo "  - picotool (flash .uf2 firmware)"
            echo "  - minicom/screen (serial communication)"
            echo ""
            echo "Quick start:"
            echo "  1. Flash MicroPython: Download .uf2 from micropython.org"
            echo "  2. Connect via USB and run: mpremote connect /dev/ttyACM0"
            echo "  3. Upload files: mpremote fs cp main.py :"
            echo "  4. Run code: mpremote run main.py"
          '';
        };
      }
    );
}
