include ./makefiles/variables.mk
include ./makefiles/init.mk

build.binary: $(SOURCE_ROOT_DIR)/pars.go $(SOURCE_ROOT_DIR)/go.mod
	@echo "Building binaries for $(APP_OS) $(APP_ARCH) on $(SOURCE_ROOT_DIR)"
	GOOS=$(APP_OS) GOARCH=$(APP_ARCH) cd $(SOURCE_ROOT_DIR) && go build -o ../$(BIN_ARTIFACTS_DIR)/$(APP) pars.go


