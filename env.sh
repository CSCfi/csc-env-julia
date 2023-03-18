#!/usr/bin/env bash
ROOT=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
MODULEPATH="$ROOT/modulefiles:$MODULEPATH"
export MODULEPATH
