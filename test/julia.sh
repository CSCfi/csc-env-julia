#!/usr/bin/env bash

# Exit if script is sourced.
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && exit 1

set -euo pipefail

SCRIPT_DIR=$(dirname "$0")

case ${1:-} in
    puhti|mahti)
        module purge
        module load "julia/$JULIA_VERSION"
        module load "julia-cuda/$JULIA_VERSION"
        module list
        export CSC_SYSTEM_NAME=$1
        ;;
    lumi)
        module purge
        module use /appl/local/csc/modulefiles
        module load "julia/$JULIA_VERSION"
        module load "julia-amdgpu/$JULIA_VERSION"
        module list
        export CSC_SYSTEM_NAME=$1
        ;;
    *)
        exit 1
        ;;
esac

julia "$SCRIPT_DIR/runtests.jl"
