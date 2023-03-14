#!/usr/bin/env bash
srun --account=project_2001659 \
    --time=00:15:00 \
    --mem-per-cpu=1G \
    --partition=gputest \
    --gres=gpu:v100:1 \
    module load cuda && \
    julia -e 'using CUDA; CUDA.set_runtime_version!("local")'
