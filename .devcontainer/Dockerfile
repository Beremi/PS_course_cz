# Use an R base image
FROM rocker/r-ver:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    libcurl4-openssl-dev \
    libssl-dev

# Install Jupyter and IRKernel
RUN R -e "install.packages(c('IRkernel', 'repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest', 'languageserver'))"
RUN R -e "IRkernel::installspec(user = FALSE)"
RUN pip3 install jupyter

# Expose Jupyter port
EXPOSE 8888
