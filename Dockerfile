FROM rocker/binder:4.2.0

# Copy your repository contents to the image
COPY --chown=rstudio:rstudio . ${HOME}

## Run an install.R script, if it exists.
RUN if [ -f install.R ]; then R --quiet -f install.R; fi

COPY Pipfile .

RUN pip install pipenv && PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy --skip-lock
