{ pkgs ? import <nixpkgs> {} }:

let
  scripts = pkgs.symlinkJoin {
    name = "py3-scripts";
    paths = [
      (pkgs.writeShellScriptBin "setup-pyproject" ''
        BASE_DIR="${./.}" ${builtins.readFile ./scripts/setup.sh}
      '')
    ];
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    (python312.withPackages (ps: with ps;
      [ flake8 pip pytest ruff virtualenv ]
    ))
    git tree scripts
  ];

  shellHook = ''
    setup-pyproject

    echo ""
    echo "🐍 Python 3.12 Development Environment"
    echo "📂 Project: $(basename $(pwd))"
    echo "🐍 Version: $(python --version 2>&1)"

    if [ -f "requirements.txt" ] && [ -s "requirements.txt" ]; then
      PACKAGES=$(pip list --format=freeze 2>/dev/null | wc -l)
      echo "📦 Packages: $PACKAGES installed"
    fi

    echo ""
    echo "💡 Available commands:"
    echo "  setup-pyproject  - Initialize/update project structure"
    echo "  make help        - Commands declared in Makefile"
    echo ""
  '';
}
