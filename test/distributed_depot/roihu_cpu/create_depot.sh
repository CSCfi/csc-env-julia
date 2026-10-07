#!/usr/bin/env bash
set -euo pipefail

cd "$(realpath "$(dirname "$0")")"

module purge
module load julia

# Precompile to unique depot dir
DEPOT_DIR=$(mktemp -d)
trap 'rm -rf "${DEPOT_DIR}"' EXIT
export JULIA_DEPOT_PATH="${DEPOT_DIR}:"

julia --project=. -e 'import Pkg; Pkg.instantiate()'

# Pack and compress the depot dir and place it on Lustre
tar czf depot.tar.gz --directory "${DEPOT_DIR}" .
