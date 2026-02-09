#!/bin/sh

set -e

BASE_DIR="/opt/exporters/ecoflow_exporter"
SRC_DIR="${BASE_DIR}/src/go-ecoflow-exporter"
BIN_NAME="ecoflow-exporter"
REPO_URL="https://github.com/tess1o/go-ecoflow-exporter.git"

mkdir -p "${BASE_DIR}/src"

if [ ! -d "${SRC_DIR}" ]; then
    git clone "${REPO_URL}" "${SRC_DIR}"
fi

cd "${SRC_DIR}"

git pull

go build -o "${BASE_DIR}/${BIN_NAME}"
