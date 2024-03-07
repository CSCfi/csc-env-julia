#!/bin/bash

usage="
Install Julia using Ansible.

USAGE
    ./install.sh <systemname> <target> <version>

EXAMPLES
    Install Julia version 1.10.2 to Puhti:

    ./install.sh puhti julia 1.10.2

    Install MPI preferences for version 0.20 to Puhti:

    ./install.sh puhti mpi 0.20

    Install CUDA preferences for version 5.2 to Puhti:

    ./install.sh puhti cuda 5.2
"

SYSTEMNAME=$1
TARGET=$2
VERSION=$3
shift 3

case $SYSTEMNAME in
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
    *)
        echo "$usage" >&2
        exit 1
        ;;
esac

ansible-playbook -i hosts.yaml -l "$GROUPNAME" -e "version=$VERSION" "$TARGET/install.yaml" "$@"
