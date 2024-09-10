include ./makefiles/variables.mk
include ./makefiles/init.mk

STAGE =
STAGE_FLAG := 
ifdef STAGE
    STAGE_FLAG := -X 'parsdevkit.net/core/utils.stage=$(STAGE)'
endif

build.binary: $(SOURCE_ROOT_DIR)/pars.go $(SOURCE_ROOT_DIR)/go.mod
	@echo "Building binaries for $(APP_OS) $(APP_ARCH) on $(SOURCE_ROOT_DIR)"
	cd $(SOURCE_ROOT_DIR) && GOOS=$(APP_OS) GOARCH=$(APP_ARCH) go build -ldflags="-X 'parsdevkit.net/core/utils.version=$(APP_TAG)' $(STAGE_FLAG) -buildid=$(APPLICATION_NAME)" -o ../$(BIN_ARTIFACTS_DIR)/$(APP) pars.go

build.binary.vendor: $(SOURCE_ROOT_DIR)/pars.go $(SOURCE_ROOT_DIR)/go.mod
	@echo "Building binaries for $(APP_OS) $(APP_ARCH) on $(SOURCE_ROOT_DIR)"
	mkdir -p $(TMP_ROOT_DIR)/.gocache $(TMP_ROOT_DIR)/.gomodcache
	cd $(SOURCE_ROOT_DIR) && GOCACHE=$(TMP_ROOT_DIR)/.gocache GOMODCACHE=$(TMP_ROOT_DIR)/.gomodcache GOFLAGS=-mod=vendor GOOS=$(APP_OS) GOARCH=$(APP_ARCH) go build -ldflags="-X 'parsdevkit.net/core/utils.version=$(APP_TAG)' $(STAGE_FLAG) -buildid=$(APPLICATION_NAME)" -o ../$(BIN_ARTIFACTS_DIR)/$(APP) pars.go
