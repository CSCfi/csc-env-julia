#!/usr/bin/env bash

set -e

_choice_julia_linux_x86_64_version() {
    ls ./install/julia/version/linux-x86_64 | sed 's/\.yaml//g'
}

# @cmd
# @meta require-tools ansible-playbook
# @option --target![localhost|puhti|mahti|lumi]
# @option --version![`_choice_julia_linux_x86_64_version`]
install_julia_linux_x86_64() {
    ansible-playbook \
        -i hosts.yaml \
        -l "group_${argc_target}" \
        -e "version=${argc_version}" \
        -e "arch=linux-x86_64" \
        "./install/julia/install.yaml" "$@"
}

_choice_mpi_version() {
    ls ./install/mpi/version
}

# @cmd
# @meta require-tools ansible-playbook
# @option --target![puhti|mahti|lumi]
# @option --version![`_choice_mpi_version`]
install_mpi() {
    ansible-playbook \
        -i hosts.yaml \
        -l "group_${argc_target}" \
        -e "version=${argc_version}" \
        "./install/mpi/install.yaml" "$@"
}

_choice_cuda_version() {
    ls ./install/cuda/version
}

# @cmd
# @meta require-tools ansible-playbook
# @option --target![puhti|mahti]
# @option --version![`_choice_cuda_version`]
install_cuda() {
    ansible-playbook \
        -i hosts.yaml \
        -l "group_${argc_target}" \
        -e "version=${argc_version}" \
        "./install/cuda/install.yaml" "$@"
}

_choice_amdgpu_version() {
    ls ./install/amdgpu/version
}

# @cmd
# @meta require-tools ansible-playbook
# @option --target=lumi
# @option --version![`_choice_amdgpu_version`]
install_amdgpu() {
    ansible-playbook \
        -i hosts.yaml \
        -l "group_${argc_target}" \
        -e "version=${argc_version}" \
        "./install/amdgpu/install.yaml" "$@"
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"