FROM tensorflow/tensorflow:1.15.0-gpu-py3
USER root

ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ >/etc/timezone \
    && apt-get update --allow-unauthenticated --yes \
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV CODE_VERSION=4.89.0
ENV PASSWORD=123456
RUN curl -fOL https://github.com/coder/code-server/releases/download/v$CODE_VERSION/code-server_${CODE_VERSION}_amd64.deb \
    && dpkg -i code-server_${CODE_VERSION}_amd64.deb \
    && rm -f code-server_${CODE_VERSION}_amd64.deb

RUN addgroup --gid 1000 dockeru && \
    adduser --uid 1000 --ingroup dockeru --home /home/dockeru --shell /bin/zsh --disabled-password --gecos "" dockeru

RUN USER=dockeru && \
    GROUP=dockeru && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.6.0/fixuid-0.6.0-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

USER dockeru

RUN EXT_LIST="ms-python.python ms-toolsai.jupyter github.github-vscode-theme ms-ceintl.vscode-language-pack-zh-hans" \
    && for EXT in $EXT_LIST; do code-server --install-extension $EXT; done \
    && sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t robbyrussell

RUN echo 'export PATH=/home/dockeru/.local/bin:$PATH' >> /home/dockeru/.zshrc

ENTRYPOINT ["fixuid"]

EXPOSE 8080

CMD code-server --host 0.0.0.0 --locale=zh-cn