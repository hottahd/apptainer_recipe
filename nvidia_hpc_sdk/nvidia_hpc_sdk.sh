#!/bin/bash

cwd=$(pwd -P)

apptainer shell \
    --nv \
    -B /scr:/scr \
    -B $HOME:$HOME \
    --home $HOME \
    nvidia_hpc_sdk.sif