#!/bin/sh

IMAGE_NAME="u1804dev:1.0"
CONTAINER_NAME="u1804dev"

case $1 in

  build)
    docker build . --tag $IMAGE_NAME
    ;;
  run)
    docker run -it --rm \
      -v "$HOME/.ssh/:/home/base/.ssh/" \
      --name $CONTAINER_NAME \
      --hostname $CONTAINER_NAME \
      $IMAGE_NAME bash
    ;;
  clean)
    docker image rm -f $IMAGE_NAME
    ;;
  *)
    echo "please specify cmd"
    ;;
esac
