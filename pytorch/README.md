# pytorch

`pytorch`でGPUを見つつ、`pyR2D2`にもアクセスできるコンテナ

# Install

MS fontをインストールするために`Dropbox/setting/fonts`を`./apptainer_recipe/pytorch`にコピー

```shell
apptainer build --fakeroot pytorch.sif pytorch.def
```

# Execution

```shell
bash pytorch.sh shell
```