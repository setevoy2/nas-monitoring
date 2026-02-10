PREFIX=/usr/local
BIN_NAME=ecoflow_exporter
BASE_DIR=/opt/exporters/ecoflow_exporter
RC_DIR=$(PREFIX)/etc/rc.d

.PHONY: build install clean upgrade

build:
	$(BASE_DIR)/build.sh

install:
	install -m 0755 $(BASE_DIR)/$(BIN_NAME) $(PREFIX)/bin/$(BIN_NAME)
	install -m 0755 $(BASE_DIR)/rc.d/$(BIN_NAME) $(RC_DIR)/$(BIN_NAME)

clean:
	rm -f $(BASE_DIR)/$(BIN_NAME)

upgrade:
	service ecoflow_exporter stop || true
	$(MAKE) build
	$(MAKE) install
	service ecoflow_exporter start
