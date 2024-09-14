include ./makefiles/variables.mk
include ./makefiles/init.mk


SNAP-BASE ?= "core22"
SNAP_ROOT_DIR = $(PACKAGE_ROOT_DIR)/snap
SNAP_CONFIG_DIR = etc/$(APPLICATION_NAME)
SNAP_LOG_DIR = var/log/$(APPLICATION_NAME)
SNAP_DATA_DIR = var/lib/$(APPLICATION_NAME)
SNAP_DATA_DATABASE_DIR = $(SNAP_DATA_DIR)/data
SNAP_CACHE_DIR = var/cache/$(APPLICATION_NAME)
SNAP_TMP_DIR = var/tmp/$(APPLICATION_NAME)
SNAP_BINARY_DIR = usr/bin
SNAP_LIB_DIR = usr/lib/$(APPLICATION_NAME)
SNAP_SHARE_DIR = usr/share/$(APPLICATION_NAME)
SNAP_DOCS_DIR = usr/share/doc/$(APPLICATION_NAME)
SNAP_BINARY_PATH = $(SNAP_BINARY_DIR)/$(APPLICATION_NAME)



SNAP_SNAP_DIR = $(SNAP_BASE_DIR)/snap
SNAP_SNAPCRAFT_FILE_PATH = $(SNAP_SNAP_DIR)/snapcraft.yaml
SNAP_BASE_DIR = $(SNAP_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
