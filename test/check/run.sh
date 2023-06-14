#!/usr/bin/env bash
set -euo pipefail
module purge

NAME=$1
case $NAME in
    puhti|mahti)
        ;;
    lumi)
        module use /appl/local/csc/modulefiles
        ;;
    *)
        exit 1
        ;;
esac

module load "julia/$JULIA_VERSION"
module list

# Check manual availability
man -w julia

# Check environment
julia "./$NAME.jl"
