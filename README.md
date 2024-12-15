# Apptainer container recipe collection

## pyR2D2: 研究の再現性確保

研究であるデータを解析したものの、数年後にオペレーティングシステムなどの変更により、解析の再現が困難になることがある。

そのような事態を避けるために、Apptainer (Singularity)を用いたコンテナを用意し、研究データと一緒に保存することにする。

筆者は[pyR2D2](https://github.com/hottahd/pyR2D2)を解析に用いており、このバージョン管理を行いたい。

### 手順

主な手順は以下である。

1. 新しいプロジェクトを始める時はこのレポジトリをクローンし、`py`とする。
2. `pyR2D2.def`で定義されているようにコンテナを作成する。
    ```shell
    apptainer build --fakeroot pyR2D2.sif pyR2D2.def
    ```
3. コンテナの起動は以下の2通り

    1. シェルを使う場合
        ```shell
        ./pyR2D2.sh shell
        ```
        shell内部でipythonなどを使い、解析を進める。

    2. jupyter notebookを使う場合
        ```shell
        ./pyR2D2.sh run
        ```
        これを実行すると`http://localhost:8888`に実行環境が生成されるので、vs codeのCreate New Jupyter NotebookなどでURLを入力し接続する。

    再現性の観点では、Jupyter Notebookが良いであろう。

4. 研究をまとめて、論文が出版されたら当該ディレクトリをコピーし、`py_freeze`とし、以降変更できないようにする。

### 考え方

1. 一論文、一コンテナ
2. `.bashrc`, `matplotlibrc`などの設定ファイルはコンテナには含まず、このレポジトリに含む
3. 研究進行中の`pyR2D2`や`pyR2D2.def`の変更は許される

## conda_test 

作成パッケージをテストするための環境

```shell
apptainer build --fakeroot conda_test.sif conda_test.def
```

テスト用ディレクトリ`/path/to/test`を用意し、そこをホームディレクトリとする。

```shell
apptainer shell --home /path/to/test conda_test.sif
```

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