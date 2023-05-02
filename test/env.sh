#!/usr/bin/env sh
if [ "$USER" = "kuu-akka" ]; then
    SBATCH_ACCOUNT=project_2000197
else
    SBATCH_ACCOUNT=project_2001659
fi

export SBATCH_ACCOUNT
