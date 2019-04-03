cur_dir = $(shell pwd)
MAKE_CONTEXT_DIR = $(abspath .)
TARGET = ./lib/init.sh

.PHONY: all install clean test

all:

install:
	$(call exec,install)

clean:
	$(call exec,clean)

define exec
	@bash -c "set -xe; . $(TARGET) $(MAKE_CONTEXT_DIR) $(cur_dir) && $1"
endef
