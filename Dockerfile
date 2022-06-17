FROM jupyter/scipy-notebook

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

COPY install.R .

RUN arch=$(uname -m) && \
    if [ "${arch}" == "aarch64" ]; then \
        export G_SLICE=always-malloc; \
    fi && \
    mamba install --quiet --yes \
    'r-base' \
    'r-devtools' \
    'r-forecast' \
    'r-hexbin' \
    'r-htmlwidgets' \
    'r-irkernel' \
    'rpy2' \
    'unixodbc' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    pip install torch numpy networkx && \
    R --quiet -f install.R

WORKDIR "${HOME}"
