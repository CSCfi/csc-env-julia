#!/usr/bin/env sh
set -eu

JULIA_VERSION=${1:-"1.8.5"}
JULIA_APPLDIR="/appl/soft/math/julia"
JULIA_GPG="3673DF529D9049477F76B37566E3C7DC03D6E495"
JULIA_URL_TAR="https://github.com/JuliaLang/julia/releases/download/v${JULIA_VERSION}/julia-${JULIA_VERSION}.tar.gz"
JULIA_URL_ASC="${JULIA_URL_TAR}.asc"

# Change directory
cd "$JULIA_APPLDIR"

# Download the source code and signature.
#curl --location "$JULIA_URL_TAR" --remote-name
#curl --location "$JULIA_URL_ASC" --remote-name
wget "$JULIA_URL_TAR"
wget "$JULIA_URL_ASC"

# Verify the integrity of the downloaded source code.
gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$JULIA_GPG"
gpg --batch --verify "julia-${JULIA_VERSION}.tar.gz.asc" "julia-${JULIA_VERSION}.tar.gz"

