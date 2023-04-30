# https://hub.docker.com/layers/nixos/nix/2.15.0/images/sha256-251a921be086aa489705e31fa5bd59f2dadfa0824aa7f362728dfe264eb6a3d2?context=explore
# 2.15.0
FROM nixos/nix:2.11.1

RUN nix-channel --update

WORKDIR /src/

RUN mkdir -p ~/.config/nix
RUN echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

COPY ./ /src/

# RUN nix run .#applyhome
# RUN nix-build 