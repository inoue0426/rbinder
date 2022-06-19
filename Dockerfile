FROM jupyter/r-notebook:r-4.1.3

RUN if [ -f install.R ]; then R --quiet -f install.R; fi && \
    pip install --user numpy pandas torch networkx
