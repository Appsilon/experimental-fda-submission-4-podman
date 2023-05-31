FROM r-base:4.2.0

RUN apt-get update --quiet \
   && apt-get install curl libcurl4-openssl-dev -y --quiet \
   && apt-get autoremove -y --quiet \
   && apt-get clean --quiet \
   && rm -rf /var/lib/apt/lists/*

ARG APP_DIR=/usr/local/src/submissions-pilot2

COPY ./submissions-pilot2 $APP_DIR

WORKDIR $APP_DIR

RUN Rscript -e "install.packages(\"renv\")" \
  && Rscript -e "renv::restore()"

COPY ./docker_app.R $APP_DIR/docker_app.R

CMD ["Rscript", "docker_app.R"]
