#!/usr/bin/env bash
# Build a Julia depot for this project and pack it into depot.tar.zst.
set -euo pipefail

# Run from the script's directory so --project=. and the tarball path resolve here
cd "$(realpath "$(dirname "$0")")"

module purge
module load julia

# Precompile to unique depot dir, removed on exit
DEPOT_DIR=$(mktemp -d)
trap 'rm -rf "${DEPOT_DIR}"' EXIT
# Trailing ':' appends Julia's default depots (bundled stdlib) after ours
export JULIA_DEPOT_PATH="${DEPOT_DIR}:"

# Install and precompile the packages from Project.toml/Manifest.toml
julia --project=. -e 'import Pkg; Pkg.instantiate()'

# Pack and compress the depot dir and place it on Lustre
tar --zstd -cf depot.tar.zst --directory "${DEPOT_DIR}" .
