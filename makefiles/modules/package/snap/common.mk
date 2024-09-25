include ./makefiles/variables.mk
include ./makefiles/init.mk


SNAP_PACK_TYPE ?= source
ARCH_FLAG_VALUE := $(strip $(call determine_arch_flag_value))
ARCH_FOLDER := $(strip $(call determine_arch_folder,$(SNAP_PACK_TYPE)))
PACK_ROOT_DIR := $(strip $(call determine_pack_dir,$(SNAP_PACK_TYPE)))

define arch_to_snap
  $(if $(strip $(1)),\
    $(if $(filter $(ARCH_386),$(1)),i386,\
    $(if $(filter $(ARCH_AMD64),$(1)),amd64,\
    $(if $(filter $(ARCH_ARM64),$(1)),arm64,\
    $(if $(filter $(ARCH_ARM),$(1)),armhf,\
    $(error Unsupported architecture: $(1)))))))
endef

define determine_snap_arch
  $(if $(strip $(ARCH)),\
    $(call arch_to_snap,$(ARCH)),\
    $(if $(filter binary,$(1)),\
      $(call arch_to_snap,$(APP_ARCH)),\
      all))
endef
SNAP_PACK_ARCH := $(strip $(call determine_snap_arch,$(SNAP_PACK_TYPE)))


SNAP-BASE ?= "core22"
SNAP_PACKAGE_EXT = .snap
SNAP_ROOT_DIR = $(PACKAGE_ROOT_DIR)/snap
SNAP_BUILD_ROOT_DIR = $(SNAP_ROOT_DIR)/$(PACK_ROOT_DIR)
SNAP_BUILD_CONFIG_DIR = $(SNAP_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
SNAP_BUILD_PAYLOAD_DIR = $(SNAP_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
SNAP_BUILD_OUTPUT_DIR = $(SNAP_BUILD_ROOT_DIR)/output
SNAP_BUILD_TEMP_DIR = $(SNAP_BUILD_ROOT_DIR)/tmp
SNAP_BUILD_OUTPUT_SNAP_FILES = $(wildcard $(SNAP_BUILD_OUTPUT_DIR)/*$(SNAP_PACKAGE_EXT))


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