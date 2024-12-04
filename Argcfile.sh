#!/usr/bin/env bash

set -e

# @cmd
# @meta require-tools ansible-playbook
# @option --target![localhost|puhti|mahti|lumi]
# @option --version!
# @option --arch=linux-x86_64
install_julia() {
    ansible-playbook \
        -i hosts.yaml \
        -l "group_${argc_target}" \
        -e "version=${argc_version}" \
        -e "arch=${argc_arch}" \
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
        "./install.cuda/install.yaml" "$@"
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
