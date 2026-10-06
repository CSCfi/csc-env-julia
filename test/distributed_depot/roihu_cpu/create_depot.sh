#!/usr/bin/env bash
set -euo pipefail

# Precompile to unique depot dir
DEPOT_DIR=$(mktemp -d)
mkdir -p ${DEPOT_DIR}
export JULIA_DEPOT_PATH="${DEPOT_DIR}:"

julia --project=. -e 'import Pkg; Pkg.precompile()'

# Pack and compress the depot dir and place it on Lustre
tar czf depot.tar.gz --directory ${DEPOT_DIR} .

# Remove the tmp
rm -rf ${DEPOT_DIR}
