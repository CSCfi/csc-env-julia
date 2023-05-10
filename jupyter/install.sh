#!/usr/bin/env bash
set -eu
JULIA_JUPYTER_ENV_DIR=$JULIA_APPL_DIR/jupyter-env
python3.9 -m venv "$JULIA_JUPYTER_ENV_DIR"
export PATH="$JULIA_JUPYTER_ENV_DIR/bin:$PATH"
pip install -r requirements.txt
pip freeze -r requirements.txt > requirements-freeze.txt
jupyter kernelspec uninstall -y python3
