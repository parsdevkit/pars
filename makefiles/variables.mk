export OS_LINUX = linux
export OS_WINDOWS = windows
export OS_MACOS = darwin
export OS_FREEBSD = freebsd
export OS_NETBSD = netbsd
export OS_OPENBSD = openbsd

export ARCH_386 = 386
export ARCH_AMD64 = amd64
export ARCH_ARM = arm
export ARCH_ARM64 = arm64

export LINUX_ARCH_386_VALUE = i386
export LINUX_ARCH_AMD64_VALUE = amd64
export LINUX_ARCH_ARM_VALUE = armhf
export LINUX_ARCH_ARM64_VALUE = arm64

export LINUX_RPM_ARCH_386_VALUE = i386
export LINUX_RPM_ARCH_AMD64_VALUE = x86_64
export LINUX_RPM_ARCH_ARM_VALUE = armhfp
export LINUX_RPM_ARCH_ARM64_VALUE = aarch64

export MAC_ARCH_X86_64_VALUE="x86_64"
export MAC_ARCH_ARM64_VALUE="arm64"

export BSD_ARCH_I386_VALUE="i386"
export BSD_ARCH_AMD64_VALUE="amd64"
export BSD_ARCH_ARM_VALUE="arm"
export BSD_ARCH_ARM64_VALUE="aarch64"

export WINDOWS_ARCH_X86_VALUE="x86"
export WINDOWS_ARCH_AMD64_VALUE="amd64"
export WINDOWS_ARCH_ARM_VALUE="arm"
export WINDOWS_ARCH_ARM64_VALUE="arm64"

export TAR_GZ_EXT = .tar.gz
export TAR_BZ2_EXT = .tar.bz2
export ZIP_EXT = .zip
export TAR_XZ_EXT = .tar.xz
export SEVEN_Z_EXT = .7z
export RAR_EXT = .rar
export LZ_EXT = .lz
export ZST_EXT = .zst


ALL_FORMATS = $(TAR_GZ_EXT) $(TAR_BZ2_EXT) $(ZIP_EXT) $(TAR_XZ_EXT) $(ZST_EXT) $(SEVEN_Z_EXT) $(RAR_EXT) $(LZ_EXT)
ifeq ($(APP_OS),$(OS_LINUX))
	FORMATS = $(TAR_GZ_EXT) $(TAR_BZ2_EXT) $(ZIP_EXT) $(TAR_XZ_EXT) $(ZST_EXT) $(SEVEN_Z_EXT) $(RAR_EXT)
else ifeq ($(APP_OS),$(OS_WINDOWS))
	FORMATS = $(ZIP_EXT) $(SEVEN_Z_EXT) $(RAR_EXT)
else ifeq ($(APP_OS),$(OS_MACOS))
	FORMATS = $(TAR_GZ_EXT) $(TAR_BZ2_EXT) $(ZIP_EXT) $(TAR_XZ_EXT) $(ZST_EXT) $(SEVEN_Z_EXT)
else ifeq ($(APP_OS),$(OS_FREEBSD))
	FORMATS = $(TAR_GZ_EXT) $(TAR_XZ_EXT) $(ZIP_EXT) $(LZ_EXT) $(SEVEN_Z_EXT)
else ifeq ($(APP_OS),$(OS_NETBSD))
	FORMATS = $(TAR_GZ_EXT) $(TAR_XZ_EXT) $(ZIP_EXT) $(LZ_EXT) $(SEVEN_Z_EXT)
else ifeq ($(APP_OS),$(OS_OPENBSD))
	FORMATS = $(TAR_GZ_EXT) $(TAR_XZ_EXT) $(ZIP_EXT) $(LZ_EXT) $(SEVEN_Z_EXT)
endif


APPLICATION_FULL_NAME := Pars
APPLICATION_NAME := pars
ORGANIZATION := Pars Community
MAINTANER := Pars Dev Kit <parsdevkit@gmail.com>
OWNER := Ahmet Soner <ahmettsoner@gmail.com>
HOMEPAGE := https://parsdevkit.net
GIT := https://github.com/parsdevkit/pars
LICENCE_TYPE := Apache-2.0
SUMMARY := $(APPLICATION_FULL_NAME) is a simple utility.
DESCRIPTION := $(APPLICATION_FULL_NAME) is a simple utility.
# https://chatgpt.com/c/66ea726e-144c-8004-8646-e740d553f106

STAGE ?= final
HOST_OS =
HOST_ARCH =

APP = $(APPLICATION_NAME)
APP_OS ?= $(OS)
APP_ARCH ?= $(ARCH)
APP_TAG ?=
APP_STAGE ?= $(STAGE)


RELEASE_DATE = 25.8.2024
RELEASE_DATE_STD := $(shell echo $(RELEASE_DATE) | awk -F. '{printf "%04d-%02d-%02d\n", $$3, $$2, $$1}')


ROOT_DIR = .
MAKEFILE_PATH = ./Makefile
SOURCE_ROOT_DIR = ./src
MAKEFILES_ROOT_DIR = ./makefiles
DIST_ROOT_DIR = ./dist
DOCS_ROOT_DIR = ./docs
TMP_ROOT_DIR := ./tmp
DOCS_USER_DOCS_DIR = $(DOCS_ROOT_DIR)/user_docs
DIST_CURRENT_DIR = $(DIST_ROOT_DIR)/$(APP_TAG)
BIN_ROOT_DIR = $(DIST_CURRENT_DIR)/build/$(APP_OS)/bin/$(APP_ARCH)
PACKAGE_ROOT_DIR = $(DIST_CURRENT_DIR)/build/$(APP_OS)/pkg
DIST_ARTIFACTS_DIR = $(DIST_CURRENT_DIR)/artifacts
DIST_RELEASE_ROOT_DIR = $(DIST_CURRENT_DIR)/release
CHANGELOG_PATH = $(DIST_RELEASE_ROOT_DIR)/release-notes.md

LINUX_TMP_ROOT_DIR := /tmp
