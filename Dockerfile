FROM rpy2/base-ubuntu:master-22.04

RUN R -e "install.packages('BiocManager')" && \
    R -e "BiocManager::install('rcellminer')" && \
    pip install networkx torch
