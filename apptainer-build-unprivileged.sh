#!/bin/bash
set -euo pipefail

: ${IMAGE:=-apptainer-install-unprivileged:latest}
DIST=
ARCH=$(arch)
VERSION=

usage() {
    echo "usage: $0 -d DIST [install-unprivileged.sh opts]"
}

while getopts 'a:d:hv:' opt; do
    case "$opt" in
        a)
            ARCH="$OPTARG"
            ;;
        d)
            DIST="$OPTARG"
            ;;
        h)
            usage
            exit 0
            ;;
        v)
            VERSION="$OPTARG"
            ;;
    esac
done

if [[ -z $DIST ]]; then
    usage
    exit 1
fi

if [[ -z $VERSION ]]; then
    echo "Querying Apptainer releases on GitHub for latest version, use -v to override"
    VERSION=$(curl -s https://api.github.com/repos/apptainer/apptainer/releases/latest | jq -r '.tag_name' | tr -d v)
    echo "Latest version: $VERSION"
    set -- "$@" -v "$VERSION"
fi

if [[ -z $(docker images -q "$IMAGE") ]]; then
    echo "Building Docker image: $IMAGE"
    docker build -t "$IMAGE" docker
fi

mkdir -p work
rm -rf "work/apptainer-${VERSION}-${DIST}-${ARCH}"
docker run --rm -v $(pwd)/work:/work --user $(id -u):$(id -g) "$IMAGE" "$@" "/work/apptainer-${VERSION}-${DIST}-${ARCH}"
tar zcvf "work/apptainer-${VERSION}-${DIST}-${ARCH}.tar.gz" -C "work" "apptainer-${VERSION}-${DIST}-${ARCH}"
echo "Apptainer package in: $(pwd)/work/apptainer-${VERSION}-${DIST}-${ARCH}.tar.gz"
