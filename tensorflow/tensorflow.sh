#!/bin/bash

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"

SIF_FILE="$SCRIPT_DIR/tensorflow.sif"

export XAUTHORITY=$SCRIPT_DIR/.Xauthority

apptainer shell \
    -B /scr:/scr \
    -B ~/.ssh:$SCRIPT_DIR/.ssh \
    -B $HOME:$HOME \
    -B ~/.Xauthority:$SCRIPT_DIR/.Xauthority \
    --env XAUTHORITY=$SCRIPT_DIR/.Xauthority \
    --env DISPLAY=$DISPLAY \
    --home $HOME \
    "$SIF_FILE"