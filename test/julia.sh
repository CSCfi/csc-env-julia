#!/usr/bin/env bash
set -euo pipefail

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

julia runtests.jl
