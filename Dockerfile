FROM jupyter/r-notebook:r-4.1.3
USER root

COPY install.R .
RUN if [ -f install.R ]; then R --quiet -f install.R; fi
RUN pip install --user numpy pandas torch networkx
