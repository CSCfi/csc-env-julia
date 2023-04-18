#!/bin/bash
#SBATCH --job-name=distributed_multinode
#SBATCH --account=project_2001659
#SBATCH --partition=test
#SBATCH --time=00:05:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=4000
#SBATCH --nodelist=r07c[05-06]
module load julia/1.8.5
julia --project=. test.jl
