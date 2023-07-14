ARG R_VERSION=4.2.0
ARG IMAGE_REGISTRY=docker.io
ARG IMAGE_ORG=rocker

FROM $IMAGE_REGISTRY/$IMAGE_ORG/r-ver:$R_VERSION

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
      org.opencontainers.image.source="https://github.com/Appsilon/experimental-fda-submission-4-podman" \
      org.opencontainers.image.vendor="Appsilon" \
      org.opencontainers.image.authors="André Veríssimo <andre.verissimo@appsilon.com>, Vedha Viyash <vedha@appsilon.com>"

RUN apt-get update --quiet \
   && apt-get install -y --quiet \
     curl \
     libssl-dev \
     libcurl4-openssl-dev \
     libxml2-dev \
     libfontconfig1-dev \
     libharfbuzz-dev libfribidi-dev \
     libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \
   && apt-get autoremove -y --quiet \
   && apt-get clean --quiet \
   && rm -rf /var/lib/apt/lists/*

RUN useradd -m shiny

ENV RENV_PATHS_ROOT=/home/shiny/renv

COPY ./renv_cache/ $RENV_PATHS_ROOT

# Make sure user has correct permissions on
RUN chown -R shiny:shiny $RENV_PATHS_ROOT

USER shiny

ARG LOCAL_DIR=./submissions-pilot2
ARG APP_DIR=/home/shiny/submissions-pilot2

COPY $LOCAL_DIR $APP_DIR

WORKDIR $APP_DIR

RUN ls -ln /home/shiny/submissions-pilot2
RUN ls -ln /home/shiny/submissions-pilot2/renv
RUN ls -ln /home/shiny/submissions-pilot2/renv/library
RUN ls -ln /home/shiny/submissions-pilot2/renv/library/R-4.3
RUN ls -ln /home/shiny/submissions-pilot2/renv/library/R-4.3/x86_64-pc-linux-gnu

# Prevents RENV from mistakenly download from teal.* remotes (as the dependencies are
#  already defined in renv.lock).
RUN Rscript \
  -e "options(\"renv.config.install.remotes\" = FALSE)" \
  -e "renv::load()" \
  -e "renv::restore()"

ARG R_SCRIPT=./entrypoint.R

COPY $R_SCRIPT $APP_DIR/entrypoint.R

CMD ["Rscript", "entrypoint.R"]
