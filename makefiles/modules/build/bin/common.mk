include ./makefiles/variables.mk
include ./makefiles/init.mk


BINARY_BUILD_STAGE_FLAG := 
ifdef APP_STAGE
    BINARY_BUILD_STAGE_FLAG := -X 'parsdevkit.net/core/utils.stage=$(APP_STAGE)'
endif


BIN_BUILD_ROOT_DIR = $(BIN_ROOT_DIR)
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

define compress
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@echo "Compressing $< to $@..."
	@EXT=$(1); \
	FILENAME=$$(basename $<); \
	BASENAME=$${FILENAME%_*}; \
	MATCH_ARCH=$${FILENAME##*_}; \
	MATCH_ARCH_NO_EXT=$${MATCH_ARCH%$(BIN_BUILD_OUTPUT_EXT)}; \
	OUTPUT_NAME=$(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$$MATCH_ARCH_NO_EXT.$(1); \
	case $$EXT in \
		$(ZIP_EXT)) zip -r $$OUTPUT_NAME $<;; \
		$(TAR_GZ_EXT)) tar -czf $$OUTPUT_NAME -C $< .;; \
		$(TAR_BZ2_EXT)) tar -cjf $$OUTPUT_NAME -C $< .;; \
		$(TAR_XZ_EXT)) tar -cJf $$OUTPUT_NAME -C $< .;; \
		$(SEVEN_Z_EXT)) tar -cf - $< | 7z a $$OUTPUT_NAME -;; \
		$(RAR_EXT)) tar -cf - $< | rar a $$OUTPUT_NAME -;; \
		$(LZ_EXT)) tar --lzma -cf $$OUTPUT_NAME -C $< .;; \
		$(ZST_EXT)) tar -cf - $< | zstd -z -o $$OUTPUT_NAME;; \
		*) echo "Unsupported format: $$EXT" >&2; exit 1;; \
	esac
endef



# Define compression rules
$(DIST_ARTIFACTS_DIR)/%$(TAR_GZ_EXT): $(BIN_BUILD_OUTPUT_DIR)
	$(call compress,$(TAR_GZ_EXT))

$(DIST_ARTIFACTS_DIR)/%$(TAR_GZ_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(TAR_XZ_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(TAR_BZ2_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(ZIP_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))
	
$(DIST_ARTIFACTS_DIR)/%$(RAR_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(SEVEN_Z_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(ZST_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(LZ_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))


# $(foreach format,$(FORMATS),$(eval $(DIST_ARTIFACTS_DIR)/%$(format): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT) ; $(call compress_file,$(DEB_PACKAGE_EXT)) ))
package.deb.source.create-artifacts: $(addprefix $(DIST_ARTIFACTS_DIR)/, $(foreach format,$(FORMATS),$(notdir $(DEB_FILES:$(DEB_PACKAGE_EXT)=$(format)))))

