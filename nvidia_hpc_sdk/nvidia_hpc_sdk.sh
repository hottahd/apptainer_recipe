#!/bin/bash

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"

SIF_FILE="$SCRIPT_DIR/nvidia_hpc_sdk.sif"

apptainer shell \
    --nv \
    -B /scr:/scr \
    -B $HOME:$HOME \
    --home $HOME \
    "$SIF_FILE"