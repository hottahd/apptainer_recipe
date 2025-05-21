# NVIDIA HPC SDK
https://catalog.ngc.nvidia.com/orgs/nvidia/containers/nvhpc

# Install

```shell
apptainer build --fakeroot nvidia_hpc_sdk.sif nvidia_hpc_sdk.def
```

# Execution

```shell
bash nvidia_hpc_sdk.sh
```

# Link

シェルスクリプトはどこからでも実行できるようになっているので、パスの通っているところにおいて実行すると良い

```shell
mkdir $HOME/bin
ln -s /path/to/nvidia_hpc_sdk.sh $HOME/bin/nvidia_hpc_sdk
```

# Docker
## Install
```shell
docker build -t hh-nvhpc \
  --build-arg USERNAME=$(id -un) \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) \
  --build-arg HOME_DIR=$HOME \
  .
```

## Launch

```shell

```