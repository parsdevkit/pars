include ./makefiles/modules/package/snap/common.mk

SNAP_BUILD_ROOT_DIR = $(SNAP_ROOT_DIR)/binary/$(APP_ARCH)

binary/snap-init:
	@mkdir -p $(SNAP_SNAP_DIR)

binary/snapcraft.yaml:
	echo "name: $(APPLICATION_NAME)" > $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "version: '$(RAW_VERSION)'" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "summary: $(SUMMARY)" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "description: $(DESCRIPTION)" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "base: $(SNAP-BASE)" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "grade: stable" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "confinement: strict" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "architectures:" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "  - build-on: [amd64]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    build-for: [amd64]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "  - build-on: [arm64]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    build-for: [arm64]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "  - build-on: [i386]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    build-for: [i386]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "  - build-on: [armhf]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    build-for: [armhf]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "apps:" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "  $(APPLICATION_NAME):" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    command: bin/\$$SNAPCRAFT_ARCH_TRIPLET/$(APPLICATION_NAME)" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "parts:" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "  $(APPLICATION_NAME):" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    source: bin/" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    plugin: dump" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    source-type: local" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "" >> $(SNAP_SNAPCRAFT_FILE_PATH)




binary/snap-files: binary/snap-init binary/snapcraft.yaml

package.snap.build.binary: binary/snap-files
	@mkdir -p $(SNAP_SNAP_DIR)

	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_386)
	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_AMD64)
	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_ARM)
	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_ARM64)
	cd $(SNAP_BASE_DIR) && snapcraft
	@echo "Package has been created with version $(APP_TAG)"

package.snap.move-binary-to-package-source:
	@mkdir -p $(SNAP_BASE_DIR)/bin/$(BUILD_ARCH)
	# $(MAKE) build.binary.linux TAG=$(APP_TAG) ARCH=$(APP_ARCH)
	cp -r $(BIN_ROOT_DIR)/$(APP) $(SNAP_BASE_DIR)/bin/$(BUILD_ARCH)
