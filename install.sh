#!/bin/bash
#
# Install Julia using Ansible.
#
# EXAMPLES
#     Install Julia version 1.10.2 to Puhti:
#
#     ./install.sh puhti julia 1.10.2
#
#     Install MPI preferences for version 0.20 to Puhti:
#
#     ./install.sh puhti mpi 0.20
#
#     Install CUDA preferences for version 5.2 to Puhti:
#
#     ./install.sh puhti cuda 5.2

set -euo pipefail

SYSTEMNAME=$1
TARGET=$2
VERSION=$3
shift 3

case $SYSTEMNAME in
    local|localhost)
        ansible-playbook -i hosts.yaml -l group_localhost -e "version=$VERSION" "$TARGET/install.yaml" "$@"
        ;;
    puhti)
        ansible-playbook -i hosts.yaml -l group_puhti -e "version=$VERSION" "$TARGET/install.yaml" "$@"
        ;;
    mahti)
        ansible-playbook -i hosts.yaml -l group_mahti -e "version=$VERSION" "$TARGET/install.yaml" "$@"
        ;;
    lumi)
        ansible-playbook -i hosts.yaml -l group_lumi -e "version=$VERSION" "$TARGET/install.yaml" "$@"
        ;;
    *)
        exit 1
        ;;
esac
