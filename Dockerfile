FROM rpy2/base-ubuntu:master-22.04

RUN R -e "install.packages('BiocManage')" && \
    R -e "BiocManager::install('rcellminer')" && \
    pip install networkx torch
