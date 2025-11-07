#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

module use /appl/local/csc/modulefiles
module load julia
module list
julia runtests.jl lumi
