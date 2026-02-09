#!/bin/sh

# stop on first error
set -e

BASE_DIR="/opt/exporters/zfs_exporter"
SRC_DIR="${BASE_DIR}/src/zfs_exporter"
BIN_NAME="zfs_exporter"
REPO_URL="https://github.com/pdf/zfs_exporter.git"

# ensure src dir exists
mkdir -p "${BASE_DIR}/src"

# clone repo if it does not exist
if [ ! -d "${SRC_DIR}" ]; then
    git clone "${REPO_URL}" "${SRC_DIR}"
fi

cd "${SRC_DIR}"

# always update sources
git pull

# build binary into BASE_DIR
go build -o "${BASE_DIR}/${BIN_NAME}"

