FROM r-base:4.2.0

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

ARG APP_DIR=/usr/local/src/submissions-pilot2

COPY ./submissions-pilot2 $APP_DIR

WORKDIR $APP_DIR

RUN Rscript -e "install.packages(\"renv@0.15.2\")"

RUN Rscript -e "renv::restore()"

COPY ./docker_app.R $APP_DIR/docker_app.R

CMD ["Rscript", "docker_app.R"]
