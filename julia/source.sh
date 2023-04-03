#!/usr/bin/env sh
set -eu

# Julia version to install
JULIA_VERSION=${1:-"1.8.5"}

# Constants
JULIA_GPG="3673DF529D9049477F76B37566E3C7DC03D6E495"
URL_TAR="https://github.com/JuliaLang/julia/releases/download/v${JULIA_VERSION}/julia-${JULIA_VERSION}.tar.gz"
URL_ASC="${URL_TAR}.asc"

# Download the source code and signature.
#curl --location "$URL_TAR" --remote-name
#curl --location "$URL_ASC" --remote-name
wget "$URL_TAR"
wget "$URL_ASC"

# Verify the integrity of the downloaded source code.
gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$JULIA_GPG"
gpg --batch --verify "julia-${JULIA_VERSION}.tar.gz.asc" "julia-${JULIA_VERSION}.tar.gz"

