#!/bin/bash

cwd=$(pwd -P)

# There is a warning when host and container have different XAUTHORITY environment variables
# We define XAUTHORITY just to suppress warning.
export XAUTHORITY=$cwd/.Xauthority

apptainer shell \
    -B /scr:/scr \
    -B ~/.ssh:$cwd/.ssh \
    -B $HOME:$HOME \
    -B ~/.Xauthority:$cwd/.Xauthority \
    --env XAUTHORITY=$cwd/.Xauthority \
    --env DISPLAY=$DISPLAY \
    --home $cwd \
    hpcissh.sif