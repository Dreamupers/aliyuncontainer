FROM nvidia/cuda:11.6.1-runtime-ubuntu20.04
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
    python3.8 \
    python3-pip \
    zsh \
    curl \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3 /usr/bin/python

ENV CODE_VERSION=4.89.0
ENV PASSWORD=zx072707
RUN curl -fOL https://github.com/coder/code-server/releases/download/v$CODE_VERSION/code-server_${CODE_VERSION}_amd64.deb \
    && dpkg -i code-server_${CODE_VERSION}_amd64.deb \
    && rm -f code-server_${CODE_VERSION}_amd64.deb

RUN pip install --no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu116 \
    torch==1.13.1+cu116 \
    torchvision==0.14.1+cu116

RUN addgroup --gid 1000 dockeru && \
    adduser --uid 1000 --ingroup dockeru --home /home/dockeru --shell /bin/sh --disabled-password --gecos "" dockeru

USER dockeru

RUN EXT_LIST="ms-python.python ms-toolsai.jupyter github.github-vscode-theme ms-ceintl.vscode-language-pack-zh-hans" \
    && for EXT in $EXT_LIST; do code-server --install-extension $EXT; done \
    && sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t robbyrussell

COPY requirements.txt /home/dockeru/requirements.txt
RUN echo 'export PATH=/home/dockeru/.local/bin:$PATH' >> /home/dockeru/.zshrc \
    && pip --no-cache-dir install -r /home/dockeru/requirements.txt \
    && rm -rf /tmp/* \
    && rm -rf /home/dockeru/.cache

ENTRYPOINT ["fixuid"]

EXPOSE 8080

CMD code-server --host 0.0.0.0 --locale=zh-cn