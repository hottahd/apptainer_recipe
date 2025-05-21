#!/bin/bash

cd "$HOME/Repository/apptainer_recipe/nvidia_hpc_sdk" || {
  echo "ディレクトリに移動できません"
  exit 1
}

env UID=$(id -u) GID=$(id -g) HOME=$HOME docker compose run --rm hpc