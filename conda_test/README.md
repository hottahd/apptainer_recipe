# conda_test

自ら作成したpythonパッケージを綺麗な環境でテストするためのコンテナ。

```shell
apptainer build --fakeroot conda_test.sif conda_test.def
```

テスト用ディレクトリ`/path/to/test`を用意し、そこをホームディレクトリとする。

```shell
apptainer shell --home /path/to/test conda_test.sif
```

テストが終わったら`/path/to/test`は削除する。