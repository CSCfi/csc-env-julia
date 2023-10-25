#!/usr/bin/env bash
set -euo pipefail

module purge
module load julia-jupyter
module list

which jupyter
#jupyter --version
jupyter --paths
jupyter kernelspec list
