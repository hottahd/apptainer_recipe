# hpcissh
## HPCI SSHクライアントをコンテナ化したもの。HPCIのSSH接続を行うためのツールである。

1. `hpcissh.def`で定義されているようにコンテナを作成する。
    ```shell
    apptainer build --fakeroot hpcissh.sif hpcissh.def
    ```
3. コンテナの起動は以下
    ```shell
    ./hpcissh.sh
    ```
