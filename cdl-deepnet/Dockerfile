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
    && if [ -n "$CONDA_PACKAGES" ]; then \
           conda install -y $CONDA_PACKAGES; \
       fi \
    && if [ -n "$PIP_VERSION" ]; then \
           conda install -Sy pip=$PIP_VERSION \
           && pin_package pip major min; \
       fi \
    && conda clean --all -f -y \
    && pip install \
        tensorflow==2.3.1 \
        pystan==2.19.1.1 \
        edward==1.3.5 \
        pyro-ppl==1.4.0 \
        $PIP_PACKAGES \
    && rm -rf ~/.cache/pip \
    && source /etc/profile.d/pin_conda_package_version.sh \
    && pin_package tensorflow minor equal \
    && pin_package pystan minor equal \
    && pin_package edward exact equal \
    && pin_package pyro-ppl minor equal \
    && pin_package numpy exact min