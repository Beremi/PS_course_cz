# Pre-built Dev Container Image for R. More info: https://github.com/rocker-org/devcontainer-images/pkgs/container/devcontainer%2Ftidyverse
# Available R version: 4, 4.1, 4.0
ARG VARIANT="4"
FROM ghcr.io/rocker-org/devcontainer/tidyverse:${VARIANT}

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    libcurl4-openssl-dev \
    libssl-dev \
    libzmq5 \
    git\
    libudunits2-0 \
    libudunits2-dev \
    libproj-dev \
    libgdal-dev \
    libzmq5-dev

RUN install2.r --error --skipinstalled -n -1 \
    statip \
    patchwork \
    paletteer \
    here \
    doParallel \
    janitor \
    vip \
    ranger \
    palmerpenguins \
    skimr \
    nnet \
    kernlab \
    plotly \
    factoextra \
    cluster \
    tidymodels \
    markdown \
    ottr \
    binom \
    BSDA \
    car \
    dplyr \
    dunn.test \
    EnvStats \
    epiR \
    FSA \
    lawstat \
    lsr \
    moments \
    nortest \
    openxlsx \
    rcompanion \
    readxl \
    robustbase \
    stringi \
    rstatix \
    ggplot2 \
    ggmosaic \
    tidyr \
    && rm -rf /tmp/downloaded_packages

RUN echo -e "auth-none=1\nauth-minimum-user-id=500" | sudo tee -a /etc/rstudio/rserver.conf > /dev/null