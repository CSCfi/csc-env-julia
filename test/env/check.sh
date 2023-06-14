#!/usr/bin/env bash
set -euo pipefail

if [ -d "$HOME/.julia" ]; then
    echo "remove $HOME/.julia before running the checks"
    exit 1
fi

module purge
module load julia/1.8.5
module list

man -w julia
julia ./check.jl
