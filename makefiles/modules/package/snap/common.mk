include ./makefiles/variables.mk
include ./makefiles/init.mk

ifeq ($(SNAP_ARCH),$(LINUX_ARCH_AMD64_VALUE))
	BUILD_SNAP_HOST_ARCH = $(ARCH_AMD64)
else ifeq ($(SNAP_ARCH),$(LINUX_ARCH_ARM64_VALUE))
	BUILD_SNAP_HOST_ARCH = $(ARCH_ARM64)
else ifeq ($(SNAP_ARCH),$(LINUX_ARCH_ARM_VALUE))
	BUILD_SNAP_HOST_ARCH = $(ARCH_ARM)
else ifeq ($(SNAP_ARCH),$(LINUX_ARCH_386_VALUE))
	BUILD_SNAP_HOST_ARCH = $(ARCH_386)
endif


SNAP_PACK_TYPE ?= source

ifdef ARCH
	ARCH_FLAG_VALUE := $(APP_ARCH)
	ARCH_FOLDER := $(APP_ARCH)
else
	ARCH_FLAG_VALUE := $$(BUILD_SNAP_HOST_ARCH)
	ifeq ($(SNAP_PACK_TYPE),binary)
		ARCH_FOLDER := $(APP_ARCH)
	else  
		ARCH_FOLDER := all
	endif
endif


ifeq ($(SNAP_PACK_TYPE),binary)
	SNAP_PACK_DIR = binary/$(ARCH_FOLDER)
else ifeq ($(SNAP_PACK_TYPE),source)
	SNAP_PACK_DIR = source/$(ARCH_FOLDER)
endif




SNAP-BASE ?= "core22"
SNAP_PACKAGE_EXT = .snap
SNAP_FILES = $(wildcard $(SNAP_BUILD_OUTPUT_DIR)/*$(SNAP_PACKAGE_EXT))

SNAP_ROOT_DIR = $(PACKAGE_ROOT_DIR)/snap
SNAP_BUILD_ROOT_DIR = $(SNAP_ROOT_DIR)/$(SNAP_PACK_DIR)
SNAP_BUILD_CONFIG_DIR = $(SNAP_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
SNAP_BUILD_PAYLOAD_DIR = $(SNAP_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
SNAP_BUILD_TEMP_DIR = $(SNAP_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
SNAP_BUILD_OUTPUT_DIR = $(SNAP_BUILD_ROOT_DIR)/output


snap-init:
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@mkdir -p $(SNAP_BUILD_ROOT_DIR)
	@mkdir -p $(SNAP_BUILD_CONFIG_DIR)
	@mkdir -p $(SNAP_BUILD_PAYLOAD_DIR)
	@mkdir -p $(SNAP_BUILD_TEMP_DIR)
	@mkdir -p $(SNAP_BUILD_OUTPUT_DIR)



snapcraft.yaml:
	echo "name: $(APPLICATION_NAME)" > $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "version: '$(RAW_VERSION)'" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "summary: $(SUMMARY)" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "description: $(DESCRIPTION)" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "base: $(SNAP-BASE)" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "grade: stable" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "confinement: strict" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "architectures:" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "  - build-on: [amd64]" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "    build-for: [amd64]" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "  - build-on: [arm64]" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "    build-for: [arm64]" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "  - build-on: [i386]" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "    build-for: [i386]" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "  - build-on: [armhf]" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "    build-for: [armhf]" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "apps:" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "  $(APPLICATION_NAME):" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "    command: bin/$(APPLICATION_NAME)" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "parts:" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "  $(APPLICATION_NAME):" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "    source: ." >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "    plugin: go" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "    build-snaps: [go/latest/stable]" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "    source-type: local" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "    build-packages:" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	# echo "      - golang-go" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "    override-build: |" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "      mkdir -p \$$SNAPCRAFT_PART_INSTALL/bin" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "      $(MAKE) build.binary.linux.vendor TAG=$(APP_TAG) OUTPUT=\$$SNAPCRAFT_PART_INSTALL/bin" >> $(SNAP_BUILD_CONFIG_DIR)/$@
	echo "" >> $(SNAP_BUILD_CONFIG_DIR)/$@

package.snap.prepare.config: snap-init snapcraft.yaml
