# functions for building various versions of image

build_default() {
    local image_dir="$GITHUB_WORKSPACE/cdl-pytorch"
    docker build --rm --force-rm \
        -f "$image_dir/Dockerfile" \
        -t "$DOCKER_HUB_ORG/cdl-pytorch:$PYTHON_VERSION" \
        --build-arg PYTHON_VERSION="$PYTHON_VERSION" \
        "$image_dir"
}

build_custom() {
    local image_dir="$GITHUB_WORKSPACE/cdl-pytorch"
    # passing --build-arg without a value causes environment variable with
    # matching name to be used
    source "$GITHUB_WORKSPACE/cdl-pytorch/ci/custom-args.sh"
    docker build --rm --force-rm \
        -f "$image_dir/Dockerfile" \
        -t "$DOCKER_HUB_ORG/cdl-pytorch:${PYTHON_VERSION}-custom" \
        --build-arg PYTHON_VERSION \
        --build-arg APT_PACKAGES \
        --build-arg CONDA_PACKAGES \
        --build-arg PIP_PACKAGES \
        --build-arg WORKDIR \
        --build-arg PORT \
        "$image_dir"
}