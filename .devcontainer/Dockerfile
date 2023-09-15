# Use an R base image
FROM rocker/r-ver:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    libcurl4-openssl-dev \
    libssl-dev \
    libzmq5 \
    libzmq5-dev

# Install Jupyter first
RUN pip3 install jupyter

# Ensure jupyter is in the PATH (though it should be by default after pip install)
ENV PATH=$PATH:/root/.local/bin/

# Install Jupyter and IRKernel
RUN R -e "install.packages(c('IRkernel', 'repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest', 'languageserver'))"
RUN R -e "IRkernel::installspec(user = TRUE)"

# Expose Jupyter port
EXPOSE 8888
