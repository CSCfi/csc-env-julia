#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

module load julia
module list
julia runtests.jl puhti
