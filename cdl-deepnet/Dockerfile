ARG PYTHON_VERSION=3.8
FROM contextlab/cdl-pytorch:$PYTHON_VERSION

LABEL maintainer="Paxton Fitzpatrick <paxton.c.fitzpatrick@dartmouth.edu>"

# have to re-declare this here because FROM clears all args
ARG PYTHON_VERSION=3.8

# define other build-time variables
ARG APT_PACKAGES=""
ARG CONDA_PACKAGES=""
ARG PIP_VERSION=""
ARG PIP_PACKAGES=""
ARG WORKDIR="/mnt"
ARG NOTEBOOK_IP=0.0.0.0
ARG PORT=8888

# update relevant environment variables set in base image in case they were passed here
ENV NOTEBOOK_DIR $WORKDIR
ENV NOTEBOOK_IP $NOTEBOOK_IP
ENV NOTEBOOK_PORT $PORT

# also update working directory, in case passed here
WORKDIR $WORKDIR

RUN echo "Building with Python $PYTHON_VERSION" \
    && if [ -n "$APT_PACKAGES" ]; then \
           apt-get update --fix-missing \
           && eatmydata apt-get install -y --no-install-recommends $APT_PACKAGES \
           && apt-get clean \
           && rm -rf /var/lib/apt/lists/*; \
       fi \
    && source /etc/profile.d/pin_conda_package_version.sh \
    && conda install -Sy --override-channels -c anaconda tensorflow=2.2.0 \
    && pin_package tensorflow minor equal \
    && conda install -Sy \
        pystan=2.19.11 \
        $CONDA_PACKAGES \
    && pin_package pystan minor equal \
    && if [ -n "$PIP_VERSION" ]; then \
           conda install -Sy pip=$PIP_VERSION \
           && pin_package pip major min; \
       fi \
    && conda clean --all -f -y \
    && pip install \
        Edward==1.3.5 \
        pyro-ppl==1.4.0 \
        $PIP_PACKAGES \
    && rm -rf ~/.cache/pip \
    && pin_package Edward exact equal \
    && pin_package pyro-ppl minor equal