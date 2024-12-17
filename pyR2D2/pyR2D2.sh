#!/bin/bash

if [ $# = 0 ]; then
    echo "Usage: pyR2D2.sh [run|shell]"
    exit 1
fi
if [[ "$1" != "run" && "$1" != "shell" ]]; then
    echo "Error: Invalid argument '$1'"
    echo "Usage: pyR2D2.sh [run|shell]"
    exit 1
fi

cwd=$(pwd -P)

# There is a warning when host and container have different XAUTHORITY environment variables
# We define XAUTHORITY just to suppress warning.
export XAUTHORITY=$cwd/.Xauthority

apptainer $1 \
    -B /scr:/scr \
    -B ~/.ssh:$cwd/.ssh \
    -B ~/.Xauthority:$cwd/.Xauthority \
    --env XAUTHORITY=$cwd/.Xauthority \
    --env DISPLAY=$DISPLAY \
    --home $cwd \
    pyR2D2.sif