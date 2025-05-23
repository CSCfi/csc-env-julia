#!/usr/bin/env bash

set -e

_choice_julia_version_linux_x86_64() {
    ls ./install/julia/version/linux-x86_64 | sed 's/\.yaml//g'
}

# @cmd Install Julia for Linux x86_64
# @meta require-tools ansible-playbook
# @option --system![puhti|mahti|lumi]
# @option --version![`_choice_julia_version_linux_x86_64`]
install-julia-linux-x86-64() {
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "system_name=${argc_system}" \
        -e "version=${argc_version}" \
        -e "arch=linux-x86_64" \
        "./install/julia/install.yaml" "$@"
}

_choice_julia_version_linux_aarch64() {
    ls ./install/julia/version/linux-aarch64 | sed 's/\.yaml//g'
}

# @cmd Install Julia for Linux aarch64 (ARM)
# @meta require-tools ansible-playbook
# @option --system!
# @option --version![`_choice_julia_version_linux_aarch64`]
install-julia-linux-aarch64() {
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "system_name=${argc_system}" \
        -e "version=${argc_version}" \
        -e "arch=linux-aarch64" \
        "./install/julia/install.yaml" "$@"
}

_choice_mpi_version() {
    ls ./install/mpi/version
}

# @cmd Install MPI.jl preferences
# @meta require-tools ansible-playbook
# @option --system![puhti|mahti|lumi]
# @option --version![`_choice_mpi_version`]
install-mpi() {
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "system_name=${argc_system}" \
        -e "version=${argc_version}" \
        "./install/mpi/install.yaml" "$@"
}

_choice_cuda_version() {
    ls ./install/cuda/version
}

# @cmd Install CUDA.jl preferences
# @meta require-tools ansible-playbook
# @option --system![puhti|mahti]
# @option --version![`_choice_cuda_version`]
install-cuda() {
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "system_name=${argc_system}" \
        -e "version=${argc_version}" \
        "./install/cuda/install.yaml" "$@"
}

_choice_amdgpu_version() {
    ls ./install/amdgpu/version
}

# @cmd Install AMDGPU.jl preferences
# @meta require-tools ansible-playbook
# @option --system=lumi
# @option --version![`_choice_amdgpu_version`]
install-amdgpu() {
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "system_name=${argc_system}" \
        -e "version=${argc_version}" \
        "./install/amdgpu/install.yaml" "$@"
}

_choice_jupyter_version() {
    ls ./install/jupyter/version | sed 's/\.yaml//g'
}

# @cmd Install Jupyter for IJulia.jl
# @meta require-tools ansible-playbook
# @option --system![puhti|mahti|lumi]
# @option --version![`_choice_jupyter_version`]
install-jupyter() {
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "system_name=${argc_system}" \
        -e "version=${argc_version}" \
        "./install/jupyter/install.yaml" "$@"
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"
