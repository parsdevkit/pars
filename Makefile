MAKEFILES := $(wildcard makefiles/*.mk)
APPLICATION_FULL_NAME := Pars
APPLICATION_NAME := pars
ORGANIZATION := Pars Community
MAINTANER := Pars Dev Kit <parsdevkit@gmail.com>
OWNER := Ahmet Soner <ahmettsoner@gmail.com>
HOMEPAGE := https://parsdevkit.net
GIT := https://github.com/parsdevkit/pars
LICENCE_TYPE := Apache-2.0
DESCRIPTION := $(APPLICATION_NAME) is a simple utility.
GO := go


TARGET = $(APPLICATION_NAME)
OS ?=
ARCH ?=
TAG ?= 

OS_LINUX = linux
OS_WINDOWS = windows
OS_MACOS = darwin


include $(MAKEFILES)



all: print get-deps build


SOURCE_ROOT_DIR = ./src
BIN_ROOT_DIR = ./bin/$(TAG)/$(OS)/$(ARCH)

get-deps: $(SOURCE_ROOT_DIR)/go.mod
	cd $(SOURCE_ROOT_DIR) && go mod tidy

build: $(SOURCE_ROOT_DIR)/pars.go
	cd $(SOURCE_ROOT_DIR) && GOOS=$(OS) GOARCH=$(ARCH)  $(GO) build -ldflags="-X 'parsdevkit.net/core/utils.version=$(TAG)' -buildid=$(TARGET)" -o ../$(BIN_ROOT_DIR)/$(TARGET) pars.go

build-complete: get-deps build

# init:
# 	@echo "Initialization step"

# install:
# 	@echo "Install dependencies"

# uninstall:
# 	@echo "Uninstall application"

# update:
# 	@echo "Update application"


# rebuild: clean build
# 	@echo "Rebuild application"

# clean:
# 	@echo "Clean build artifacts"

# distclean: clean
# 	@echo "Clean all generated files"

# test:
# 	@echo "Run tests"

# lint:
# 	@echo "Run linter"

# format:
# 	@echo "Format code"

# docs:
# 	@echo "Generate documentation"

# check:
# 	@echo "Check application"

# package:
# 	@echo "Package application"

# deploy:
# 	@echo "Deploy application"

# run:
# 	@echo "Run application"

# start:
# 	@echo "Start application"

# stop:
# 	@echo "Stop application"

# restart: stop start
# 	@echo "Restart application"

# status:
# 	@echo "Check application status"

# logs:
# 	@echo "Show application logs"

# backup:
# 	@echo "Backup application data"

# # restore:
# # 	@echo "Restore application data"

# migrate:
# 	@echo "Run database migrations"

# config:
# 	@echo "Configure application"

# setup:
# 	@echo "Setup environment"

# teardown:
# 	@echo "Teardown environment"

# docker-build:
# 	@echo "Build Docker image"

# docker-run:
# 	@echo "Run Docker container"

# docker-stop:
# 	@echo "Stop Docker container"

# docker-clean:
# 	@echo "Clean Docker artifacts"

# docker-push:
# 	@echo "Push Docker image to registry"

# docker-pull:
# 	@echo "Pull Docker image from registry"

# docker-compose:
# 	@echo "Run Docker Compose"

# k8s-deploy:
# 	@echo "Deploy to Kubernetes"

# k8s-undeploy:
# 	@echo "Undeploy from Kubernetes"

# k8s-status:
# 	@echo "Check Kubernetes deployment status"

# k8s-logs:
# 	@echo "Show Kubernetes logs"

# publish:
# 	@echo "Publish release"

# release:
# 	@echo "Create release"

# rollback:
# 	@echo "Rollback release"

# monitor:
# 	@echo "Monitor application"

# notify:
# 	@echo "Send notifications"

help:
	@echo "Available commands:"
	@echo "  all:			Restore and Build"
	@echo "  restore:		Get dependencies and packages"
	@echo "  build:		Build"
	@echo "  clean:		Clean up build artifacts"