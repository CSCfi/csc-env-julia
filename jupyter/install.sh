#!/usr/bin/env bash
set -euo pipefail
JULIA_JUPYTER_ENV_DIR=$1
mkdir -p "$JULIA_JUPYTER_ENV_DIR"
python3.9 -m venv "$JULIA_JUPYTER_ENV_DIR"
export PATH="$JULIA_JUPYTER_ENV_DIR/bin:$PATH"
pip install -r requirements.txt
pip freeze -r requirements.txt > requirements-freeze.txt
jupyter kernelspec uninstall -y python3
