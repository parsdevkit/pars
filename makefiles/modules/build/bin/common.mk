include ./makefiles/variables.mk
include ./makefiles/init.mk


BINARY_BUILD_STAGE_FLAG := 
ifdef APP_STAGE
    BINARY_BUILD_STAGE_FLAG := -X 'parsdevkit.net/core/utils.stage=$(APP_STAGE)'
endif


BIN_BUILD_ROOT_DIR = $(BIN_ROOT_DIR)/bin
BIN_BUILD_CONFIG_DIR = $(BIN_BUILD_ROOT_DIR)
BIN_BUILD_PAYLOAD_DIR = $(BIN_BUILD_ROOT_DIR)
BIN_BUILD_TEMP_DIR = $(BIN_BUILD_ROOT_DIR)
BIN_BUILD_OUTPUT_DIR = $(BIN_BUILD_ROOT_DIR)/output

ifdef OUTPUT
	OUTPUT_FLAG_VALUE := $(OUTPUT)
else
	OUTPUT_FLAG_VALUE := ../$(BIN_BUILD_OUTPUT_DIR)
endif

binary-init:
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@mkdir -p $(BIN_BUILD_ROOT_DIR)
	@mkdir -p $(BIN_BUILD_CONFIG_DIR)
	@mkdir -p $(BIN_BUILD_PAYLOAD_DIR)
	@mkdir -p $(BIN_BUILD_TEMP_DIR)
	@mkdir -p $(BIN_BUILD_OUTPUT_DIR)

build.binary: $(SOURCE_ROOT_DIR)/pars.go $(SOURCE_ROOT_DIR)/go.mod
	@echo "Building binaries for $(APP_OS) $(APP_ARCH) on $(SOURCE_ROOT_DIR)"
	# cd $(SOURCE_ROOT_DIR) && go mod tidy
	cd $(SOURCE_ROOT_DIR) && GOOS=$(APP_OS) GOARCH=$(APP_ARCH) go build -ldflags="-X 'parsdevkit.net/core/utils.version=$(APP_TAG)' $(BINARY_BUILD_STAGE_FLAG) -buildid=$(APPLICATION_NAME)" -o $(OUTPUT_FLAG_VALUE)/$(APP) pars.go

build.binary.vendor: $(SOURCE_ROOT_DIR)/pars.go $(SOURCE_ROOT_DIR)/go.mod
	@echo "Building binaries for $(APP_OS) $(APP_ARCH) on $(SOURCE_ROOT_DIR)"
	mkdir -p $(LINUX_TMP_ROOT_DIR)/.gocache $(LINUX_TMP_ROOT_DIR)/.gomodcache
	cd $(SOURCE_ROOT_DIR) && GO111MODULE=on GOCACHE=$(LINUX_TMP_ROOT_DIR)/.gocache GOMODCACHE=$(LINUX_TMP_ROOT_DIR)/.gomodcache GOFLAGS=-mod=vendor GOOS=$(APP_OS) GOARCH=$(APP_ARCH) go build -ldflags="-X 'parsdevkit.net/core/utils.version=$(APP_TAG)' $(BINARY_BUILD_STAGE_FLAG) -buildid=$(APPLICATION_NAME)" -o $(OUTPUT_FLAG_VALUE)/$(APP) pars.go

build.binary.all : build.binary build.binary.create-artifacts


build.binary.prepare.config : binary-init
# Define the extension and command for each compression format
TAR_GZ_EXT = .tar.gz
TAR_BZ2_EXT = .tar.bz2
ZIP_EXT = .zip
TAR_XZ_EXT = .tar.xz
SEVEN_Z_EXT = .7z
RAR_EXT = .rar
LZ_EXT = .lz
ZST_EXT = .zst

# Define the list of formats based on OS
ifeq ($(APP_OS),$(OS_LINUX))
	FORMATS = $(TAR_GZ_EXT) $(TAR_BZ2_EXT) $(ZIP_EXT) $(TAR_XZ_EXT) $(ZST_EXT)
else ifeq ($(APP_OS),$(OS_WINDOWS))
	FORMATS = $(ZIP_EXT) $(SEVEN_Z_EXT) $(RAR_EXT)
else ifeq ($(APP_OS),$(OS_MACOS))
	FORMATS = $(TAR_GZ_EXT) $(TAR_BZ2_EXT) $(ZIP_EXT) $(ZST_EXT)
else ifeq ($(APP_OS),$(OS_FREEBSD))
	FORMATS = $(TAR_GZ_EXT) $(TAR_XZ_EXT) $(ZIP_EXT) $(LZ_EXT)
else ifeq ($(APP_OS),$(OS_NETBSD))
	FORMATS = $(TAR_GZ_EXT) $(TAR_XZ_EXT) $(ZIP_EXT) $(LZ_EXT)
else ifeq ($(APP_OS),$(OS_OPENBSD))
	FORMATS = $(TAR_GZ_EXT) $(TAR_XZ_EXT) $(ZIP_EXT) $(LZ_EXT)
endif

# Define the extension variables
TAR_GZ_EXT = .tar.gz
TAR_BZ2_EXT = .tar.bz2
ZIP_EXT = .zip
TAR_XZ_EXT = .tar.xz
SEVEN_Z_EXT = .7z
RAR_EXT = .rar
LZ_EXT = .lz
ZST_EXT = .zst

# Define the extension variables
TAR_GZ_EXT = .tar.gz
TAR_BZ2_EXT = .tar.bz2
ZIP_EXT = .zip
TAR_XZ_EXT = .tar.xz
SEVEN_Z_EXT = .7z
RAR_EXT = .rar
LZ_EXT = .lz
ZST_EXT = .zst

define compress
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@echo "Compressing $< to $@..."
	@EXT=$(1); \
	case $$EXT in \
		$(ZIP_EXT)) zip -r $@ $<;; \
		$(TAR_GZ_EXT)) tar -czf $@ -C $< .;; \
		$(TAR_BZ2_EXT)) tar -cjf $@ -C $< .;; \
		$(TAR_XZ_EXT)) tar -cJf $@ -C $< .;; \
		$(SEVEN_Z_EXT)) tar -cf - $< | 7z a $@ -;; \
		$(RAR_EXT)) tar -cf - $< | rar a $@ -;; \
		$(LZ_EXT)) tar --lzma -cf $@ -C $< .;; \
		$(ZST_EXT)) tar -cf - $< | zstd -z -o $@;; \
		*) echo "Unsupported format: $$EXT" >&2; exit 1;; \
	esac
endef



# Define compression rules
$(DIST_ARTIFACTS_DIR)/%$(TAR_GZ_EXT): $(BIN_BUILD_OUTPUT_DIR)
	$(call compress,$(TAR_GZ_EXT))

$(DIST_ARTIFACTS_DIR)/%$(TAR_BZ2_EXT): $(BIN_BUILD_OUTPUT_DIR)
	$(call compress,$(TAR_BZ2_EXT))

$(DIST_ARTIFACTS_DIR)/%$(ZIP_EXT): $(BIN_BUILD_OUTPUT_DIR)
	$(call compress,$(ZIP_EXT))

$(DIST_ARTIFACTS_DIR)/%$(TAR_XZ_EXT): $(BIN_BUILD_OUTPUT_DIR)
	$(call compress,$(TAR_XZ_EXT))

$(DIST_ARTIFACTS_DIR)/%$(SEVEN_Z_EXT): $(BIN_BUILD_OUTPUT_DIR)
	$(call compress,$(SEVEN_Z_EXT))

$(DIST_ARTIFACTS_DIR)/%$(RAR_EXT): $(BIN_BUILD_OUTPUT_DIR)
	$(call compress,$(RAR_EXT))

$(DIST_ARTIFACTS_DIR)/%$(LZ_EXT): $(BIN_BUILD_OUTPUT_DIR)
	$(call compress,$(LZ_EXT))

$(DIST_ARTIFACTS_DIR)/%$(ZST_EXT): $(BIN_BUILD_OUTPUT_DIR)
	$(call compress,$(ZST_EXT))






# Create artifacts target

build.binary.create-artifacts: $(addprefix $(DIST_ARTIFACTS_DIR)/, $(foreach format,$(FORMATS),$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH)$(format)))
