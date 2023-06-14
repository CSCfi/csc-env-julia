#!/usr/bin/env bash
set -euo pipefail

# Check module loading
module purge
module load "julia/$JULIA_VERSION"
module list

# Check manual availability
man -w julia

# Check environment
julia "./$1.jl"
