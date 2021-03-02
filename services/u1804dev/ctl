#!/bin/sh

IMAGE_NAME="u1804dev:1.0"
CONTAINER_NAME="u1804dev"
LOCAL_CONTAINER_NAME=${2:-"$CONTAINER_NAME"}

run_as_daemon () {
    # run the image as a deamon with the terminal on
    echo "Running as demon $1"
    docker run -i -d \
      --network host \
      -v "/etc/kolla:/etc/kolla" \
      -v "/etc/hosts:/etc/hosts" \
      -v "$HOME/.ssh/:/home/base/.ssh/" \
      -v "$HOME/repo/:/home/base/repo/" \
      --name $1 \
      --hostname $1 \
      $IMAGE_NAME
}

one_shot () {
    echo "Running as one shot"
    docker run -it --rm \
      -v "/etc/kolla:/etc/kolla" \
      -v "/etc/hosts:/etc/hosts" \
      -v "$HOME/.ssh/:/home/base/.ssh/" \
      -v "$HOME/repo/:/home/base/repo/" \
      # --name $CONTAINER_NAME \
      # --hostname $CONTAINER_NAME \
      $IMAGE_NAME bash
}

attach () {
    echo "Attaching to container $1 bash"
    docker exec -it $1 bash
}

clean () {
    echo "Clean the container $1 bash"
    docker exec -it $1 bash
}

echo "command $1"

case $1 in

  build)
    docker build --force-rm --tag $IMAGE_NAME .
    ;;
  d)
    run_as_daemon $LOCAL_CONTAINER_NAME
    ;;
  attach)
    attach $LOCAL_CONTAINER_NAME
    ;;
  a)
    attach $LOCAL_CONTAINER_NAME
    ;;
  os)
    one_shot
    ;;
  clean)
    clean $LOCAL_CONTAINER_NAME
    ;;
  rm)
    docker rm -f $LOCAL_CONTAINER_NAME
    ;;
  *)
          echo "please specify cmd options include (build, d, attach, a, os, clean, rm)"
    ;;
esac
