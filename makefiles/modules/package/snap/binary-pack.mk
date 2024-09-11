include ./makefiles/modules/package/snap/common.mk

SNAP_BINARY_ROOT_DIR = $(SNAP_ROOT_DIR)/binary
SNAP_BINARY_ROOT_PACKAGE_DIR = $(SNAP_BINARY_ROOT_DIR)/package
SNAP_BINARY_ROOT_SOURCE_DIR = $(SNAP_BINARY_ROOT_DIR)/source

SNAP_BASE_DIR = $(SNAP_BINARY_ROOT_DIR)/$(APPLICATION_NAME)
SNAP_SNAP_DIR = $(SNAP_BASE_DIR)/snap
SNAP_SNAPCRAFT_FILE_PATH = $(SNAP_SNAP_DIR)/snapcraft.yaml

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

	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_LINUX_386)
	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_LINUX_AMD64)
	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_LINUX_ARM)
	# $(MAKE) package.snap.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_LINUX_ARM64)
	cd $(SNAP_BASE_DIR) && snapcraft
	@echo "Package has been created with version $(APP_TAG)"

package.snap.move-binary-to-package-source:
	@mkdir -p $(SNAP_BASE_DIR)/bin/$(SNAP_ARCH)
	# $(MAKE) build.binary.linux TAG=$(APP_TAG) ARCH=$(APP_ARCH)
	cp -r $(BIN_ARTIFACTS_DIR)/$(APP) $(SNAP_BASE_DIR)/bin/$(SNAP_ARCH)
