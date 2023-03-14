#!/usr/bin/env bash
module load StdEnv openmpi
julia -e 'using MPIPreferences; MPIPreferences.use_system_binary()'
