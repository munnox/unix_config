#!/bin/sh

COMMAND=${1:-'NONE'}
TYPE_FOLDER=${2:-'ubuntu'}
DOCKERFILE="${TYPE_FOLDER}/Dockerfile"
ENVFILE="${TYPE_FOLDER}/.env"
CONTAINERD="${CONTAINERD:=docker}"
[[ -e $ENVFILE ]] && source $ENVFILE && echo "ENV found and sourced from: '$ENVFILE'" || echo "ENV not found"

IMAGE_NAME="${IMAGE_NAME:-u2204dev:1.0}"

CONTAINER_NAME="${CONTAINER_NAME:-u2204dev}"
LOCAL_CONTAINER_NAME=${3:-"$CONTAINER_NAME"}


# -v "/etc/kolla:/etc/kolla" \
# -v "/etc/hosts:/etc/hosts" \

build () {
  echo "Build Image name: ${IMAGE_NAME}"
  $CONTAINERD build --force-rm --tag $IMAGE_NAME -f $DOCKERFILE .
}

run_as_daemon () {
    # run the image as a deamon with the terminal on
    echo "Running as demon $1"
    docker run -i -d \
      --network host \
      -v "$HOME/.ssh/:/home/base/.ssh/" \
      -v "$HOME/repo/:/home/base/repo/" \
      --name $1 \
      --hostname $1 \
      $IMAGE_NAME
}

one_shot () {
    echo "Running as one shot"
    $CONTAINERD run -it --rm \
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
    $CONTAINERD exec -it $1 bash
}

clean () {
    echo "Clean the container $1 bash"
    $CONTAINERD exec -it $1 bash
}

echo "Command '$COMMAND' Container program '$CONTAINERD'"

case $COMMAND in

  build)
    build
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
