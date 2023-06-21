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

RUN useradd -ms /bin/bash r_user

USER r_user

WORKDIR /home/r_user

COPY --chown=r_user ./renv.lock /home/r_user/renv.lock

COPY --chown=r_user .cache/ /home/r_user/.renv_cache

ENV RENV_PATHS_ROOT=/home/r_user/.renv_cache

RUN mkdir /home/r_user/renv \
  && mkdir /home/r_user/R

RUN Rscript \
  -e ".libPaths(c('/home/r_user/R'))" \
  -e "install.packages('renv')" \
  -e "renv::restore(exclude = c('pilot2wrappers'))"
