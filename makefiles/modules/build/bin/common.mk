include ./makefiles/variables.mk
include ./makefiles/common.mk


build.binary: $(SOURCE_ROOT_DIR)/pars.go
	@echo "Building binaries for $(APP_OS) $(APP_ARCH) on $(SOURCE_ROOT_DIR)"
	@echo GOOS=$(APP_OS) GOARCH=$(APP_ARCH) cd $(SOURCE_ROOT_DIR) && go build -o ../$(BIN_ARTIFACTS_DIR)/$(APP) pars.go
