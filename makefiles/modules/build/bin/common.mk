include ./makefiles/variables.mk
include ./makefiles/init.mk

BINARY_BUILD_STAGE_FLAG := 
ifdef APP_STAGE
    BINARY_BUILD_STAGE_FLAG := -X 'parsdevkit.net/core/utils.stage=$(APP_STAGE)'
endif

build.binary: $(SOURCE_ROOT_DIR)/pars.go $(SOURCE_ROOT_DIR)/go.mod
	@echo "Building binaries for $(APP_OS) $(APP_ARCH) on $(SOURCE_ROOT_DIR)"
	# cd $(SOURCE_ROOT_DIR) && go mod tidy
	cd $(SOURCE_ROOT_DIR) && GOOS=$(APP_OS) GOARCH=$(APP_ARCH) go build -ldflags="-X 'parsdevkit.net/core/utils.version=$(APP_TAG)' $(BINARY_BUILD_STAGE_FLAG) -buildid=$(APPLICATION_NAME)" -o ../$(BIN_ROOT_DIR)/$(APP) pars.go

build.binary.vendor: $(SOURCE_ROOT_DIR)/pars.go $(SOURCE_ROOT_DIR)/go.mod
	@echo "Building binaries for $(APP_OS) $(APP_ARCH) on $(SOURCE_ROOT_DIR)"
	mkdir -p $(LINUX_TMP_ROOT_DIR)/.gocache $(LINUX_TMP_ROOT_DIR)/.gomodcache
	cd $(SOURCE_ROOT_DIR) && GO111MODULE=on GOCACHE=$(LINUX_TMP_ROOT_DIR)/.gocache GOMODCACHE=$(LINUX_TMP_ROOT_DIR)/.gomodcache GOFLAGS=-mod=vendor GOOS=$(APP_OS) GOARCH=$(APP_ARCH) go build -ldflags="-X 'parsdevkit.net/core/utils.version=$(APP_TAG)' $(BINARY_BUILD_STAGE_FLAG) -buildid=$(APPLICATION_NAME)" -o ../$(BIN_ROOT_DIR)/$(APP) pars.go

build.binary.all : build.binary build.binary.copy-to-artifacts

build.binary.copy-to-artifacts:
ifeq ($(APP_OS),$(OS_LINUX))
	tar -czvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).tar.gz $(BIN_ROOT_DIR)
	tar -cjvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).tar.bz2 $(BIN_ROOT_DIR)
	zip $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).zip $(BIN_ROOT_DIR)


else ifeq ($(APP_OS),$(OS_WINDOWS))
	zip $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).zip $(BIN_ROOT_DIR)
	7z a $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).7z $(BIN_ROOT_DIR)
	rar a $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).rar $(BIN_ROOT_DIR)
else ifeq ($(APP_OS),$(OS_MACOS))
	tar -czvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).tar.gz $(BIN_ROOT_DIR)
	tar -cjvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).tar.bz2 $(BIN_ROOT_DIR)
	zip $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).zip $(BIN_ROOT_DIR)
else ifeq ($(APP_OS),$(OS_FREEBSD))
	tar -czvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).tar.gz $(BIN_ROOT_DIR)
	tar -cJvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).tar.xz $(BIN_ROOT_DIR)
	zip $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).zip $(BIN_ROOT_DIR)
else ifeq ($(APP_OS),$(OS_NETBSD))
	tar -czvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).tar.gz $(BIN_ROOT_DIR)
	tar -cJvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).tar.xz $(BIN_ROOT_DIR)
	zip $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).zip $(BIN_ROOT_DIR)
else ifeq ($(APP_OS),$(OS_OPENBSD))
	tar -czvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).tar.gz $(BIN_ROOT_DIR)
	tar -cJvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).tar.xz $(BIN_ROOT_DIR)
	zip $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).zip $(BIN_ROOT_DIR)
endif


