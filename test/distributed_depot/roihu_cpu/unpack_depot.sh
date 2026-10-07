#!/usr/bin/env bash
# Unpack depot.tar.zst (from create_depot.sh) into the given directory,
# typically node-local storage. Usage: unpack_depot.sh DEPOT_DIR
set -euo pipefail
DEPOT_DIR=$1
mkdir -p "${DEPOT_DIR}" && tar xf depot.tar.zst --directory="${DEPOT_DIR}"
