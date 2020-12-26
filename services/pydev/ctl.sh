#!/bin/sh

IMAGE_NAME="pydev:3.9"
CONTAINER_NAME="pydev"

case $1 in

    build)
        docker build . --tag $IMAGE_NAME
        ;;
    run)
        docker run -it --rm --name $CONTAINER_NAME $IMAGE_NAME bash
        ;;
esac
