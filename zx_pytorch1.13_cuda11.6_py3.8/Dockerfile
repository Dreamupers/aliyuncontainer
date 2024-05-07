FROM nvidia/cuda:11.6.1-runtime-ubuntu20.04
USER root

RUN apt-get update --yes \
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3 /usr/bin/python

RUN useradd -m -s /bin/zsh dockeru \
    && chown -R dockeru:dockeru /home/dockeru

USER dockeru

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -t robbyrussell

RUN pip install --no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu116 \
    torch==1.13.1+cu116 \
    torchvision==0.14.1+cu116

COPY requirements.txt /home/dockeru/requirements.txt
RUN pip --no-cache-dir install -r /home/dockeru/requirements.txt \
    && rm -rf /tmp/* \
    && rm -rf /home/dockeru/.cache

USER root

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["bash", "/tmp/entrypoint.sh"]