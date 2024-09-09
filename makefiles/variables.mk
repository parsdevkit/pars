export OS_LINUX = linux
export OS_WINDOWS = windows
export OS_MACOS = darwin
export OS_BSD = bsd

export ARCH_LINUX_386 = 386
export ARCH_LINUX_AMD64 = amd64
export ARCH_LINUX_ARM = arm
export ARCH_LINUX_ARM64 = arm64

export LINUX_ARCH_386_VALUE = i386
export LINUX_ARCH_AMD64_VALUE = amd64
export LINUX_ARCH_ARM_VALUE = armhf
export LINUX_ARCH_ARM64_VALUE = arm64

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



APPLICATION_FULL_NAME := Pars
APPLICATION_NAME := pars
ORGANIZATION := Pars Community
MAINTANER := Pars Dev Kit <parsdevkit@gmail.com>
OWNER := Ahmet Soner <ahmettsoner@gmail.com>
HOMEPAGE := https://parsdevkit.net
GIT := https://github.com/parsdevkit/pars
LICENCE_TYPE := Apache-2.0
DESCRIPTION := $(APPLICATION_NAME) is a simple utility.

HOST_OS =
HOST_ARCH =

APP = $(APPLICATION_NAME)
APP_OS ?= $(OS)
APP_ARCH ?= $(ARCH)
APP_TAG ?=

RELEASE_DATE = Tue, 24 Aug 2024 00:00:00 +0000


ROOT_DIR = .
MAKEFILE_PATH = ./Makefile
SOURCE_ROOT_DIR = ./src
MAKEFILES_ROOT_DIR = ./makefiles
DIST_ROOT_DIR = ./dist
DOCS_ROOT_DIR = ./docs
TMP_ROOT_DIR := ./tmp
DOCS_USER_DOCS_DIR = $(DOCS_ROOT_DIR)/user_docs
BIN_ROOT_DIR = $(DIST_ROOT_DIR)/$(APP_TAG)/$(APP_OS)/bin/$(APP_ARCH)
BIN_ARTIFACTS_DIR = $(BIN_ROOT_DIR)/artifacts
PACKAGE_ROOT_DIR = $(DIST_ROOT_DIR)/$(APP_TAG)/$(APP_OS)/pkg
RELEASE_ROOT_DIR = $(DIST_ROOT_DIR)/$(APP_TAG)/release
CHANGELOG_PATH = $(RELEASE_ROOT_DIR)/release-notes.md
