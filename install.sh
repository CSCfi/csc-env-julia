#!/bin/bash
set -euo pipefail

USAGE="
Install Julia and related environments using Ansible.

USAGE
    install.sh <systemname> <target> <version>

EXAMPLES
    # Install Julia version 1.10.2 to Puhti:

    install.sh puhti julia 1.10.2

    # Install MPI preferences for version 0.20 to Puhti:

    install.sh puhti mpi 0.20

    # Install CUDA preferences for version 5.2 to Puhti:

    install.sh puhti cuda 5.2

    # Install ADMGPU preferences for version 0.8 to LUMI:

    install.sh lumi amdgpu 0.8
"

case ${1:-} in
    local|localhost)
        GROUPNAME=group_localhost
        ;;
    puhti)
        GROUPNAME=group_puhti
        ;;
    mahti)
        GROUPNAME=group_mahti
        ;;
    lumi)
        GROUPNAME=group_lumi
        ;;
    help|-h|--help)
        echo "$USAGE"
        exit 0
        ;;
    *)
        echo "$USAGE" >&2
        exit 1
        ;;
esac
shift 1

TARGET=$1
shift 1

VERSION=$1
shift 1

ansible-playbook -i hosts.yaml -l "$GROUPNAME" -e "version=$VERSION" "$TARGET/install.yaml" "$@"
