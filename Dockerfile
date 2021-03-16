FROM rocker/binder:latest
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

USER root
RUN apt-get install -y libxml2-dev

RUN apt-get install -y r-cran-readxl
RUN apt-get install -y r-cran-dplyr
RUN apt-get install -y r-cran-openxlsx

USER ${NB_USER}
