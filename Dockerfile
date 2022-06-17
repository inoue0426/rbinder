# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG OWNER=jupyter
ARG BASE_CONTAINER=$OWNER/scipy-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# R pre-requisites
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

USER ${NB_UID}

COPY requirements.txt .

RUN arch=$(uname -m) && \
    if [ "${arch}" == "aarch64" ]; then \
        # Prevent libmamba from sporadically hanging on arm64 under QEMU
        # <https://github.com/mamba-org/mamba/issues/1611>
        export G_SLICE=always-malloc; \
    fi && \
    mamba install --quiet --yes \
    'r-base' \
#     'r-caret' \
#     'r-crayon' \
    'r-devtools' \
#     'r-e1071' \
    'r-forecast' \
    'r-hexbin' \
#     'r-htmltools' \
    'r-htmlwidgets' \
    'r-irkernel' \
#     'r-nycflights13' \
#     'r-randomforest' \
#     'r-rcurl' \
#     'r-rmarkdown' \
#     'r-rodbc' \
#     'r-rsqlite' \
#     'r-shiny' \
#     'r-tidyverse' \
    'rpy2' \
    'unixodbc' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    pip install torch numpy networkx 
    
RUN if [ -f install.R ]; then R --quiet -f install.R; fi && \

WORKDIR "${HOME}"
