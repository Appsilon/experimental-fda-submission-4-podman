ARG R_VERSION=4.2.0
ARG IMAGE_REGISTRY=docker.io
ARG IMAGE_ORG=rocker

FROM $IMAGE_REGISTRY/$IMAGE_ORG/r-ver:$R_VERSION

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

ARG R_SCRIPT=./docker_app.R

COPY $R_SCRIPT $APP_DIR/docker_app.R

CMD ["Rscript", "docker_app.R"]
