FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

ENV NIX_CHANNEL nixpkgs

ENV NIX_CHANNEL_URL https://nixos.org/channels/nixos-22.05

ENV NIX_PKG idris2

WORKDIR /workspace

RUN apt update

RUN apt-get install -y --no-install-recommends \
    apt-transport-https \
    software-properties-common \
    nix sudo

RUN nix-channel --add $NIX_CHANNEL_URL $NIX_CHANNEL \
    && nix-channel --update \
    && nix-env -iA $NIX_CHANNEL.$NIX_PKG \
    && nix-build "<${NIX_CHANNEL}>" -A $NIX_PKG \
    && ln -s /workspace/result/bin/$NIX_PKG /bin/$NIX_PKG

WORKDIR /code

COPY bin .
 
CMD "./run.sh"