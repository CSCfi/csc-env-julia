#!/usr/bin/env sh
set -eu

# Julia version to install
MAJOR=1
MINOR=8
PATCH=5
JULIA_VERSION="$MAJOR.$MINOR.$PATCH"

# Constants
JULIA_GPG="3673DF529D9049477F76B37566E3C7DC03D6E495"
URL_TAR="https://julialang-s3.julialang.org/bin/linux/x64/$MAJOR.$MINOR/julia-$JULIA_VERSION-linux-x86_64.tar.gz"
URL_ASC="${URL_TAR}.asc"

# Download the source code and signature.
#curl --location "$URL_TAR" --remote-name
#curl --location "$URL_ASC" --remote-name
wget "$URL_TAR"
wget "$URL_ASC"

# Verify the integrity of the downloaded source code.
gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$JULIA_GPG"
gpg --batch --verify "julia-${JULIA_VERSION}.tar.gz.asc" "julia-${JULIA_VERSION}.tar.gz"

# Extract binaries if directory does not already exist
[ -d "julia-${JULIA_VERSION}" ] || tar xf "julia-${JULIA_VERSION}.tar.gz"
