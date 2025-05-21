FROM nvcr.io/nvidia/nvhpc:25.3-devel-cuda_multi-ubuntu24.04

ARG USERNAME
ARG UID
ARG GID
ARG HOME_DIR

# パッケージのインストール
RUN apt update && \
    apt install -y nlohmann-json3-dev libyaml-cpp-dev

# 固定ユーザーと指定ホーム
RUN groupadd -g ${GID} sc && \
    useradd -m -d ${HOME_DIR} -u ${UID} -g sc -s /bin/bash ${USERNAME}

# プロンプト設定
RUN echo 'PS1="\[\e[1;33m\](app):\h:\[\e[0;36m\]\w# \[\e[m\]"' >> ${HOME_DIR}/.bashrc && \
    chown ${USERNAME}:sc ${HOME_DIR}/.bashrc

USER ${USERNAME}
WORKDIR ${HOME_DIR}