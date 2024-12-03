#!/usr/bin/env bash

set -e

# @cmd
# @option --host![=localhost|puhti|mahti|lumi]
# @option --version!
# @option --arch=linux-x86_64
install_julia() {
    ansible-playbook \
        -i hosts.yaml \
        -l "group_${argc_host}" \
        -e "version=${argc_version}" \
        -e "arch=${argc_arch}" \
        "./install/julia/install.yaml" "$@"
}

# @cmd
# @option --host![puhti|mahti|lumi]
# @option --version!
install_mpi() {
    ansible-playbook \
        -i hosts.yaml \
        -l "group_${argc_host}" \
        -e "version=${argc_version}" \
        "./install/mpi/install.yaml" "$@"
}

# @cmd
# @option --host![puhti|mahti]
# @option --version!
install_cuda() {
    ansible-playbook \
        -i hosts.yaml \
        -l "group_${argc_host}" \
        -e "version=${argc_version}" \
        "./install.cuda/install.yaml" "$@"
}

# @cmd
# @option --host![lumi]
# @option --version!
install_amdgpu() {
    ansible-playbook \
        -i hosts.yaml \
        -l "group_${argc_host}" \
        -e "version=${argc_version}" \
        "./install/amdgpu/install.yaml" "$@"
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"
