# simple makefile for zfs_exporter

PREFIX=/usr/local
BIN_NAME=zfs_exporter
BASE_DIR=/opt/exporters/zfs_exporter
RC_DIR=$(PREFIX)/etc/rc.d

.PHONY: build install clean

build:
	$(BASE_DIR)/build.sh

install:
	install -m 0755 $(BASE_DIR)/$(BIN_NAME) $(PREFIX)/bin/$(BIN_NAME)
	install -m 0755 $(BASE_DIR)/rc.d/$(BIN_NAME) $(RC_DIR)/$(BIN_NAME)

clean:
	rm -f $(BASE_DIR)/$(BIN_NAME)

upgrade:
	service zfs_exporter stop || true
	$(MAKE) build
	$(MAKE) install
	service zfs_exporter start

