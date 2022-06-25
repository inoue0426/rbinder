FROM jupyter/r-notebook:r-4.1.3
USER root

RUN R -e "install.packages('BiocManager', repos='https://cloud.r-project.org/')" && \
    R -e "BiocManager::install('rcellminer')" && \
    pip install --user torch networkx
