# Apptainer container recipe collection

研究で用いている仮想化ソフトウェアの仮想化レシピを集める。

- [pyR2D2](pyR2D2/README.md): R2D2シミュレーションの解析環境`pyR2D2`に関するコンテナ(再現性確保)
- [conda_test](conda_test/README.md): 自作pythonソフトウェアのインストールテスト環境
- [pytorch](pytorch/README.md): `pytorch` + `pyR2D2`利用のためのコンテナ
- [tensorflow](tensorflow): `tensorflow` + `pyR2D2`利用のためのコンテナ


## 仮想化ソフトウェアのインストール

Singularityは2021年のLinux Foundationへの移管に伴って、名称がApptainerへと変更になった。
Singularity自体は開発が続けられているが、完全OSSのApptainerを使うのが推奨される。

### Apptainer

[こちら](https://github.com/apptainer/apptainer/blob/main/INSTALL.md)を参照

### Singularity

[こちら](https://github.com/sylabs/singularity/blob/main/INSTALL.md)を参照

### Mac

limaを使う
```
brew install lima
```

apptainerのtemplate利用
```
limactl start template://apptainer
limactl shell apptainer
```