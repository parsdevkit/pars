include ./makefiles/modules/package/snap/common.mk

SNAP_SOURCE_ROOT_DIR = $(SNAP_ROOT_DIR)/source
SNAP_SOURCE_ROOT_PACKAGE_DIR = $(SNAP_SOURCE_ROOT_DIR)/package
SNAP_SOURCE_ROOT_SOURCE_DIR = $(SNAP_SOURCE_ROOT_DIR)/source

SNAP_BASE_DIR = $(SNAP_SOURCE_ROOT_DIR)/$(APPLICATION_NAME)
SNAP_SNAP_DIR = $(SNAP_BASE_DIR)/snap
SNAP_SNAPCRAFT_FILE_PATH = $(SNAP_SNAP_DIR)/snapcraft.yaml

source/snap-init:
	@mkdir -p $(SNAP_SNAP_DIR)

source/snapcraft.yaml:
	echo "name: $(APPLICATION_NAME)" > $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "version: '$(RAW_VERSION)'" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "summary: $(SUMMARY)" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "description: $(DESCRIPTION)" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "base: $(SNAP-BASE)" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "grade: stable" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "confinement: strict" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "architectures:" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "  - build-on: [amd64]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "    build-for: [amd64]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "  - build-on: [arm64]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "    build-for: [arm64]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "  - build-on: [i386]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "    build-for: [i386]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "  - build-on: [armhf]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "    build-for: [armhf]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "apps:" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "  $(APPLICATION_NAME):" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    command: bin/$(APPLICATION_NAME)" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "parts:" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "  $(APPLICATION_NAME):" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    source: ." >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    plugin: go" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    build-snaps: [go/latest/stable]" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    source-type: local" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "    build-packages:" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	# echo "      - golang-go" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "    override-build: |" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "      $(MAKE) package.snap.move-binary-to-package-source2 TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_LINUX_AMD64)" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "      mkdir -p \$$SNAPCRAFT_PART_INSTALL/bin" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "      cp -r $(BIN_ARTIFACTS_DIR)/$(APP) \$$SNAPCRAFT_PART_INSTALL/bin" >> $(SNAP_SNAPCRAFT_FILE_PATH)
	echo "" >> $(SNAP_SNAPCRAFT_FILE_PATH)




source/snap-files: source/snap-init source/snapcraft.yaml

package.snap.build.source: source/snap-files
	@mkdir -p $(SNAP_SNAP_DIR)
	$(MAKE) package.snap.move-source-code-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(APP_ARCH)
	cd $(SNAP_BASE_DIR) && snapcraft
	@echo "Package has been created with version $(APP_TAG)"

package.snap.move-source-to-package-source:
	@mkdir -p $(SNAP_BASE_DIR)/bin/$(SNAP_ARCH)
	$(MAKE) build.binary.linux TAG=$(APP_TAG) ARCH=$(APP_ARCH)
	cp -r $(BIN_ARTIFACTS_DIR)/$(APP) $(SNAP_BASE_DIR)/bin/$(SNAP_ARCH)

package.snap.move-source-code-to-package-source:
	cp -r $(SOURCE_ROOT_DIR) $(SNAP_BASE_DIR)
	cp -r $(MAKEFILES_ROOT_DIR) $(SNAP_BASE_DIR)
	cp -r $(DOCS_ROOT_DIR) $(SNAP_BASE_DIR)
	cp $(MAKEFILE_PATH) $(SNAP_BASE_DIR)/Makefile
	# cd $(SNAP_BASE_DIR)/src && go mod vendor
	chmod +x $(SNAP_BASE_DIR)

package.snap.move-binary-to-package-source2:
	@mkdir -p $(SNAP_BASE_DIR)/bin/$(SNAP_ARCH)
	$(MAKE) build.binary.linux TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_LINUX_AMD64)
	cp -r $(BIN_ARTIFACTS_DIR)/$(APP) $(SNAP_BASE_DIR)/bin/$(SNAP_ARCH)