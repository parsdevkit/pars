include ./makefiles/variables.mk
include ./makefiles/init.mk

GPG-KEY ?= 
DEB-SERIES ?= "noble"
DEB_ROOT_DIR = $(PACKAGE_ROOT_DIR)/deb
DEB_INSTALLATION_DIR = /usr/bin
DEB_INSTALLATION_PATH = $(DEB_INSTALLATION_DIR)/$(APPLICATION_NAME)




arch-setup:
ifeq ($(APP_ARCH),amd64)
  DEB_ARCH = amd64
else ifeq ($(APP_ARCH),arm64)
  DEB_ARCH = arm64
else ifeq ($(APP_ARCH),arm32)
  DEB_ARCH = armhf
else ifeq ($(APP_ARCH),386)
  DEB_ARCH = i386
endif