#!/bin/sh

IMAGE_NAME="u1804dev:1.0"
CONTAINER_NAME="u1804dev"

case $1 in

  build)
    docker build . --tag $IMAGE_NAME
    ;;
  d)
    # run the image as a deamon with the terminal on
    docker run -i -d \
      -v "/etc/kolla:/etc/kolla" \
      -v "/etc/hosts:/etc/hosts" \
      -v "$HOME/.ssh/:/home/base/.ssh/" \
      -v "$HOME/repo/:/home/base/repo/" \
      --name ${2:-"$CONTAINER_NAME"} \
      --hostname ${2:-"$CONTAINER_NAME"} \
      $IMAGE_NAME
    ;;
  attach)
    docker exec -it ${2:-"$CONTAINER_NAME"} bash
    ;;
  run)
    docker run -it --rm \
      -v "/etc/kolla:/etc/kolla" \
      -v "/etc/hosts:/etc/hosts" \
      -v "$HOME/.ssh/:/home/base/.ssh/" \
      -v "$HOME/repo/:/home/base/repo/" \
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
