#!/usr/bin/env bash
set -euo pipefail
strace -f -e 'open,openat,stat' julia -e "${1-}" 2> strace-julia.out
