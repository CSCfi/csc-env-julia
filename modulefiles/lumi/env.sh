#!/usr/bin/env bash
MODULEFILES=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
MODULEPATH="$MODULEFILES:$MODULEPATH"
export MODULEPATH
