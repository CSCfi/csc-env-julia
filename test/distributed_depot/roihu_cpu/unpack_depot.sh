#!/usr/bin/env bash
set -euo pipefail
DEPOT_DIR=$1
mkdir -p "${DEPOT_DIR}" && tar xf depot.tar.gz --directory="${DEPOT_DIR}"
