FROM rocker/binder:4.2.0

USER root

# Copy your repository contents to the image
COPY --chown=rstudio:rstudio . ${HOME}

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/mount/gensoft2/exe/R/3.5.0/lib64/R/lib/

## Run an install.R script, if it exists.
RUN if [ -f install.R ]; then R --quiet -f install.R; fi

COPY requirements.txt .

RUN pip install -r requirements.txt
