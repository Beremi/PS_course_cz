FROM rocker/binder:latest
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

USER root
RUN apt-get install -y libxml2-dev

# Install binaries (see https://datawookie.netlify.com/blog/2019/01/docker-images-for-r-r-base-versus-r-apt/)
RUN cat requirements-bin.txt | xargs apt-get install -y -qq

USER ${NB_USER}
