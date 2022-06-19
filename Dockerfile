FROM jupyter/r-notebook:r-4.1.3

RUN R -e 'install.packages(BiocManager)' && \
    R -e 'BiocManager::install("rcellminer")' && \
    pip install --user numpy pandas torch networkx
