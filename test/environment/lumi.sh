#!/usr/bin/env bash
set -euo pipefail

# Exit if script is sourced.
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && exit 1

module --quiet purge
module use /appl/local/csc/modulefiles
module load "julia/$JULIA_VERSION"
module load "julia-amdgpu/$JULIA_VERSION"
module list

julia "$(dirname "$0")/runtests.jl" lumi
