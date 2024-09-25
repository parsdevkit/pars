# include ./makefiles/modules/package/snap/common.mk

# SNAP_BUILD_ROOT_DIR = $(SNAP_ROOT_DIR)/binary/$(APP_ARCH)

# binary/snap-init:
# 	@mkdir -p $(SNAP_SNAP_DIR)


# binary/snap-files: binary/snap-init binary/snapcraft.yaml

# package.snap.build.binary: binary/snap-files
# 	@mkdir -p $(SNAP_SNAP_DIR)

# 	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_386)
# 	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_AMD64)
# 	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_ARM)
# 	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_ARM64)
# 	cd $(SNAP_BASE_DIR) && snapcraft
# 	@echo "Package has been created with version $(APP_TAG)"

# package.snap.move-binary-to-package-source:
# 	@mkdir -p $(SNAP_BASE_DIR)/bin/$(BUILD_ARCH)
# 	# $(MAKE) build.binary.linux TAG=$(APP_TAG) ARCH=$(APP_ARCH)
# 	cp -r $(BIN_ROOT_DIR)/$(APP) $(SNAP_BASE_DIR)/bin/$(BUILD_ARCH)
