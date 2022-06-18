FROM rpy2/base-ubuntu:master-22.04

USER root

COPY install.R .
COPY Pipfile .

RUN R --quiet -f install.R && pip install numpy pandas networkx torch
