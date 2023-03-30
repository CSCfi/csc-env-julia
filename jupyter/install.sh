#!/usr/bin/env bash
ENVDIR=/appl/soft/math/julia/jupyter-env
python3.9 -m venv "$ENVDIR"
export PATH="$ENVDIR/bin:$PATH"
pip install -r requirements.txt
pip freeze -r requirements.txt > requirements-freeze.txt
