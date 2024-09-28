# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_CONTAINER=$REGISTRY/$OWNER/scipy-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN apt-get update --yes \
    && apt-get install --yes --no-install-recommends \
    # build-essential \
    wget \
    # curl \
    # - pandoc is used to convert notebooks to html files
    #   it's not present in the aarch64 Ubuntu image, so we install it here
    pandoc \
    vim \
    # git \
    zip \
    # unzip \
    libopenmpi-dev \
    zsh \
    tmux \
    screen \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Installation de Code Server et server-proxy/vscode-proxy pour intégrer Code dans JupyterLab
# Install VSCode extensions
ENV CODE_VERSION=4.22.1
RUN curl -fOL https://github.com/coder/code-server/releases/download/v$CODE_VERSION/code-server_${CODE_VERSION}_amd64.deb && \
    dpkg -i code-server_${CODE_VERSION}_amd64.deb && \
    rm -f code-server_${CODE_VERSION}_amd64.deb
    # plugin will be install in /home/username
    # EXT_LIST="ms-python.python zhuangtongfa.material-theme" && \
    # for EXT in $EXT_LIST; do code-server --install-extension $EXT; done

# Copy environment.yml (if found) to a temp locaition so we update the environment. Also
# copy "noop.txt" so the COPY instruction does not fail if no environment.yml exists.
# COPY environment.yml noop.txt /tmp/conda-tmp/
# RUN if [ -f "/tmp/conda-tmp/environment.yml" ]; then umask 0002 && /opt/conda/bin/conda env update -n base -f /tmp/conda-tmp/environment.yml; fi \
#     && rm -rf /tmp/conda-tmp

RUN pip install --no-cache-dir \
    'torch==2.0.1' \
    'torchvision==0.15.2' \
    'torchaudio==2.0.2'  && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# mamba/conda instsall
RUN mamba install --yes \
    cudatoolkit \
    'jupyter-server-proxy' \
    'jupyter-vscode-proxy' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# [Optional] If your pip requirements rarely change, uncomment this section to add them to the image.
COPY requirements.txt noop.txt /tmp/pip-tmp/
RUN if [ -f "/tmp/pip-tmp/requirements.txt" ]; then pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt; fi \
   && rm -rf /tmp/pip-tmp \
   && fix-permissions "${CONDA_DIR}" \
   && fix-permissions "/home/${NB_USER}"

USER ${NB_UID}
