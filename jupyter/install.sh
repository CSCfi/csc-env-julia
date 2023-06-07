#!/usr/bin/env bash
set -euo pipefail
DIR=$(dirname "$0")
JULIA_JUPYTER_ENV_DIR="$CSC_APPL_DIR/soft/math/julia-jupyter/env"
mkdir -p "$JULIA_JUPYTER_ENV_DIR"
python3.9 -m venv "$JULIA_JUPYTER_ENV_DIR"
export PATH="$JULIA_JUPYTER_ENV_DIR/bin:$PATH"
pip install -r "$DIR/requirements.txt"
pip freeze -r "$DIR/requirements.txt" > "$DIR/requirements-freeze.txt"
jupyter kernelspec uninstall -y python3
