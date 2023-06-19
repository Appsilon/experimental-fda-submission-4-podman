ARG R_VERSION=4.2.0
ARG IMAGE_REGISTRY=docker.io
ARG IMAGE_ORG=rocker

FROM $IMAGE_REGISTRY/$IMAGE_ORG/r-ver:$R_VERSION

LABEL org.opencontainers.image.licenses="GPL-3.0-or-later" \
      org.opencontainers.image.source="https://github.com/Appsilon/experimental-fda-submission-4-podman" \
      org.opencontainers.image.vendor="Appsilon" \
      org.opencontainers.image.authors="André Veríssimo <andre.verissimo@appsilon.com>, Vedha Viyash <vedha@appsilon.com>"


RUN apt-get update --quiet \
   && apt-get install \
     curl \
     libssl-dev \
     libcurl4-openssl-dev \
     libxml2-dev -y --quiet \
     libfontconfig1-dev \
     libharfbuzz-dev libfribidi-dev \
     libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \
   && apt-get autoremove -y --quiet \
   && apt-get clean --quiet \
   && rm -rf /var/lib/apt/lists/*

ARG LOCAL_DIR=./submissions-pilot2
ARG APP_DIR=/usr/local/src/submissions-pilot2

COPY $LOCAL_DIR $APP_DIR

WORKDIR $APP_DIR

RUN Rscript -e "renv::restore()"

<<<<<<< HEAD
ARG R_SCRIPT=./entrypoint.R
=======
ARG R_SCRIPT=./r_scripts/docker_app.R
>>>>>>> 08323ae (feat: initial support for rhino submission)

COPY $R_SCRIPT $APP_DIR/entrypoint.R

CMD ["Rscript", "entrypoint.R"]
