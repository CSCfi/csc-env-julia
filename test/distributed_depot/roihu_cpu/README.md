# Distributed Julia depot test on Roihu CPU

Tests running Julia from a precompiled depot that is distributed from Lustre to node-local disk, rather than reading the depot from Lustre on every node.

Run from the `roihu-cpu.csc.fi` login node.

First, create the depot archive:

```bash
./create_depot.sh
```

This instantiates `Project.toml` into a temporary depot and packs it into `depot.tar.zst` in this directory.

Then, run the tests:

```bash
./runtests.sh
```

This submits a job to the `test` partition (2 nodes, 2 tasks per node). The job unpacks `depot.tar.zst` once per node into unique directory, then runs `runtests.jl` on every task with `JULIA_DEPOT_PATH` pointing to the local depot.
To use a different project, edit `--account` in `runtests.sh`.

Check the result in `test_julia_distributed_depot_<jobid>.out`. A passing run prints `Hello, world!` once per task (4 times).
