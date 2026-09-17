#!/bin/bash
# pyR2D2.sif の起動口。★このディレクトリがコンテナの home になる★（一論文一コンテナ）
#
#   ./pyR2D2.sh shell        中でシェルを使う
#   ./pyR2D2.sh run          %runscript（jupyter notebook）
#   ./pyR2D2.sh lab [ポート]  ★jupyter lab を立てっぱなしにする★（既定 8888）
#                            tmux の中で叩いて Ctrl-b d で抜ける。
#                            VS Code Remote から「Existing Jupyter Server」に URL を貼る。

usage() { echo "Usage: pyR2D2.sh [shell|run|lab [port]]"; }

case "${1:-}" in
    shell|run|lab) mode=$1 ;;
    "")            usage; exit 1 ;;
    *)             echo "Error: Invalid argument '$1'"; usage; exit 1 ;;
esac

cwd=$(pwd -P)
[ -e "$cwd/pyR2D2.sif" ] || { echo "Error: $cwd/pyR2D2.sif が無い（先に build する）"; exit 1; }

# There is a warning when host and container have different XAUTHORITY environment variables
# We define XAUTHORITY just to suppress warning.
export XAUTHORITY=$cwd/.Xauthority

binds=(-B /scr:/scr -B "$HOME:$HOME")
[ -e "$HOME/.ssh" ]         && binds+=(-B "$HOME/.ssh:$cwd/.ssh")
# ★無いファイルを bind すると apptainer が落ちる★ので、在るときだけ足す
[ -e "$HOME/.Xauthority" ]  && binds+=(-B "$HOME/.Xauthority:$cwd/.Xauthority")

if [ "$mode" = lab ]; then
    port=${2:-8888}
    # ☠★127.0.0.1 から変えないこと★☠ 0.0.0.0 にすると
    #   ★学内の誰でも任意のコードを実行できる★（混み具合ページの 8899 とは危険度が違う）。
    #   手元のブラウザで見たいときは ssh -L $port:127.0.0.1:$port <host> でトンネルする。
    # トークンは jupyter が自分で作る。★引数に載らない★ので ps からは見えない。
    echo "jupyter lab を 127.0.0.1:$port に立てる（home = $cwd）"
    exec apptainer exec "${binds[@]}" \
        --env XAUTHORITY="$cwd/.Xauthority" --env DISPLAY="$DISPLAY" \
        --home "$cwd" \
        "$cwd/pyR2D2.sif" \
        /opt/venv/bin/jupyter lab --no-browser --ip 127.0.0.1 --port "$port"
fi

exec apptainer "$mode" "${binds[@]}" \
    --env XAUTHORITY="$cwd/.Xauthority" --env DISPLAY="$DISPLAY" \
    --home "$cwd" \
    "$cwd/pyR2D2.sif"
