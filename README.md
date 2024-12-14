# 研究の再現性確保のためのコンテナレシピ集

## はじめに

研究であるデータを解析したものの、数年後にオペレーティングシステムなどの変更により、解析の再現が困難になることがある。

そのような事態を避けるために、Apptainer (Singularity)を用いたコンテナを用意し、研究データと一緒に保存することにする。

## 手順

主な手順は以下である。

1. 新しいプロジェクトを始める時はこのレポジトリをクローンし、`py`とする。
2. `pyR2D2.def`で定義されているようにコンテナを作成する。
    ```shell
    singularity build --fakeroot pyR2D2.sif pyR2D2.def
    ```
3. コンテナの起動は以下の2通り
    a. シェルを使う場合
        ```shell
        ./pyR2D2.sh shell
        ```
        shell内部でipythonなどを使い、解析を進める。
    b. jupyter notebookを使う場合
        ```shell
        ./pyR2D2.sh run
        ```
        これを実行すると`http://localhost:8888`に実行環境が生成されるので、vs codeのCreate New Jupyter NotebookなどでURLを入力し接続する。

    再現性という観点では、Jupyter Notebookが良いであろう。

4. 研究をまとめて、論文が出版されたら当該ディレクトリをコピーし、`py_freeze`とし、以降変更できないようにする。

## 考え方

1. 一論文、一コンテナ
2. .bashrc, matplotlibrcなどのファイルはコンテナには含まず、このレポジトリに含む
3. 研究進行中の`pyR2D2`や`pyR2D2.def`の変更は許される
