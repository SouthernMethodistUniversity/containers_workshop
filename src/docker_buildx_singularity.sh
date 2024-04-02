#!/usr/bin/env sh

# Build images for both x86_64 and ARM64
. ./docker_buildx.sh

# Consume the image on M3 via Singularity
ssh m3 'bash -l -c "module load apptainer\
 && apptainer run docker://rkalescky/python3 -c \"import numpy as np; print(np.pi)\""'

# Pull Docker image to a Singularity image
ssh m3 'bash -l -c "module load apptainer\
 && apptainer pull -F python3_3.9.13-slim.sif docker://python:3.9.13-slim\
 && ls -lh ./python3_3.9.13-slim.sif\
 && apptainer exec ./python3_3.9.13-slim.sif python3 -c \"import sys; print(sys.version)\""'

# Singularity mount points
ssh m3 'bash -l -c "module load apptainer\
 && echo \$APPTAINER_BIND"'

