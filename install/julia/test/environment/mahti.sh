#!/usr/bin/env bash
set -euo pipefail

# Exit if script is sourced.
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && exit 1

module --quiet purge
module load "julia/$JULIA_VERSION"
module load "julia-cuda/$JULIA_VERSION"
module list

julia "$(dirname "$0")/runtests.jl" mahti
