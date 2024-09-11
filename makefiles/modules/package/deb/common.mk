include ./makefiles/variables.mk
include ./makefiles/init.mk

GPG_KEY ?= 
DEB-SERIES ?= "noble"
DEB_ROOT_DIR = $(PACKAGE_ROOT_DIR)/deb
DEB_CONFIG_DIR = etc/$(APPLICATION_NAME)
DEB_LOG_DIR = var/log/$(APPLICATION_NAME)
DEB_DATA_DIR = var/lib/$(APPLICATION_NAME)
DEB_DATA_DATABASE_DIR = $(DEB_DATA_DIR)/data
DEB_CACHE_DIR = var/cache/$(APPLICATION_NAME)
DEB_TMP_DIR = var/tmp/$(APPLICATION_NAME)
DEB_BINARY_DIR = usr/bin
DEB_LIB_DIR = usr/lib/$(APPLICATION_NAME)
DEB_SHARE_DIR = usr/share/$(APPLICATION_NAME)
DEB_DOCS_DIR = usr/share/doc/$(APPLICATION_NAME)
DEB_BINARY_PATH = $(DEB_BINARY_DIR)/$(APPLICATION_NAME)




ifeq ($(APP_ARCH),$(ARCH_LINUX_AMD64))
  DEB_ARCH = $(LINUX_ARCH_AMD64_VALUE)
else ifeq ($(APP_ARCH),$(ARCH_LINUX_ARM64))
  DEB_ARCH = $(LINUX_ARCH_ARM64_VALUE)
else ifeq ($(APP_ARCH),$(ARCH_LINUX_ARM))
  DEB_ARCH = $(LINUX_ARCH_ARM_VALUE)
else ifeq ($(APP_ARCH),$(ARCH_LINUX_386))
  DEB_ARCH = $(LINUX_ARCH_386_VALUE)
endif


ifdef GPG_KEY
	GPG_KEY_FLAG := -k$(GPG_KEY)
endif
