#!/bin/bash

if [ $# = 0 ]; then
    echo "Usage: pyR2D2.sh [run|shell]"
    exit 1
else
    if [ $1 = "run" ]; then
        arg1=run
        arg2=
    elif [ $1 = "shell" ]; then
        arg1=
    else
        echo "Usage: pyR2D2.sh [run|shell]"
    fi
fi

cwd=$(pwd -P)

singularity run\
    -B /scr:/scr \
    -B ~/.ssh:$cwd/.ssh \
    -B ~/.Xauthority:$cwd/.Xauthority \
    --env XAUTHORITY=$cwd/.Xauthority \
    --env DISPLAY=$DISPLAY \
    --home $cwd \
    pyR2D2.sif

