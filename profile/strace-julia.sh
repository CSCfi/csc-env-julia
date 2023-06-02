#!/usr/bin/env bash
strace -f -e 'open,openat,stat' julia -e "" 2> julia-strace.out
