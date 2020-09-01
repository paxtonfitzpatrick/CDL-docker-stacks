# functions for building various versions of image

build_default() {
    image_dir="$GITHUB_WORKSPACE/cdl-datasci"
    docker build --rm --force-rm \
        -f "$image_dir/Dockerfile" \
        -t contextlab/cdl-datasci:"$IMAGE_PYTHON" \
        --build-arg PYTHON_VERSION="$IMAGE_PYTHON" \
        "$image_dir"
}

