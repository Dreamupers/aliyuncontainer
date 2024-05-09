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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update --yes \
    && apt-get install --yes --no-install-recommends \
    python3.9 \
    python3-pip \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/zsh dockeru \
    && chown -R dockeru:dockeru /home/dockeru

USER dockeru

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t robbyrussell

RUN pip install --no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu118 \
    torch==2.1.0+cu118 \
    torchvision==0.16.0+cu118

COPY requirements.txt /home/dockeru/requirements.txt
RUN pip --no-cache-dir install -r /home/dockeru/requirements.txt \
    && rm -rf /tmp/* \
    && rm -rf /home/dockeru/.cache

USER root

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["bash", "/tmp/entrypoint.sh"]