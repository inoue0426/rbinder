FROM rocker/binder:4.2.0

# Copy your repository contents to the image
COPY --chown=rstudio:rstudio . ${HOME}

COPY Pipfile .

## Run an install.R script, if it exists.
RUN R --quiet -f install.R && apt-get update && \
    apt-get install python3.10 python3-pip && \
    pip install pipenv && pipenv install --deploy --skip-lock
