# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG REGISTRY=jupyter
ARG BASE_CONTAINER=$REGISTRY/scipy-notebook:python-3.8.13
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ >/etc/timezone \
    && apt-get update --yes \
    && apt-get install --yes --no-install-recommends \
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
# Install PyTorch with pip (https://pytorch.org/get-started/locally/)
# hadolint ignore=DL3013
RUN pip install --no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu116 \
    torch==1.13.1+cu116 \
    torchvision==0.14.1+cu116 && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER $NB_UID

WORKDIR $HOME
