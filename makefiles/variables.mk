export OS_LINUX = linux
export OS_WINDOWS = windows
export OS_MACOS = darwin
export OS_BSD = bsd

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
SOURCE_ROOT_DIR = ./src
DIST_ROOT_DIR = ./dist
BIN_ROOT_DIR = $(DIST_ROOT_DIR)/$(APP_TAG)/$(APP_OS)/bin/$(APP_ARCH)
BIN_ARTIFACTS_DIR = $(BIN_ROOT_DIR)/artifacts
PACKAGE_ROOT_DIR = $(DIST_ROOT_DIR)/$(APP_TAG)/$(APP_OS)/pkg
RELEASE_ROOT_DIR = $(DIST_ROOT_DIR)/$(APP_TAG)/release
TMP_DIR := /tmp
CHANGELOG_PATH = $(RELEASE_ROOT_DIR)/release-notes.md
