#!/usr/bin/env bash
set -euo pipefail

# Check module loading
module purge
module load julia/1.8.5
module list

# Check manual availability
man -w julia

# Check environment
julia ./check.jl
