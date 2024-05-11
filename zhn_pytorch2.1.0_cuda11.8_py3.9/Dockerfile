FROM nvidia/cuda:11.8.0-runtime-ubuntu20.04
USER root

ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ >/etc/timezone \
    && apt-get update --yes \
    && apt-get install --yes --no-install-recommends \
    gosu \
    wget \
    vim \
    zip \
    htop \
    tmux \
    zsh \
    curl \
    git \
    python3.9 \
    python3-pip \
    && ln -s /usr/bin/python3.9 /usr/bin/python \
    && rm /usr/bin/python3 \
    && ln -s /usr/bin/python3.9 /usr/bin/python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/zsh dockeru \
    && chown -R dockeru:dockeru /home/dockeru

RUN pip install --no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu118 \
    torch==2.1.0+cu118 \
    torchvision==0.16.0+cu118

ENV CODE_VERSION=4.89.0
RUN curl -fOL https://github.com/coder/code-server/releases/download/v$CODE_VERSION/code-server_${CODE_VERSION}_amd64.deb \
    && dpkg -i code-server_${CODE_VERSION}_amd64.deb \
    && rm -f code-server_${CODE_VERSION}_amd64.deb

USER dockeru

RUN EXT_LIST="ms-python.python ms-toolsai.jupyter github.github-vscode-theme ms-ceintl.vscode-language-pack-zh-hans" \
    && for EXT in $EXT_LIST; do code-server --install-extension $EXT; done \
    && sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t robbyrussell

COPY requirements.txt /home/dockeru/requirements.txt
RUN pip --no-cache-dir install -r /home/dockeru/requirements.txt \
    && rm -rf /tmp/* \
    && rm -rf /home/dockeru/.cache

ENV PASSWORD=zhn123

USER root

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["bash", "/tmp/entrypoint.sh"]
EXPOSE 8080