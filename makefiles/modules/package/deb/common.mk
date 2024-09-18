include ./makefiles/variables.mk
include ./makefiles/init.mk


ifeq ($(DEB_HOST_ARCH),$(LINUX_ARCH_AMD64_VALUE))
	BUILD_DEB_HOST_ARCH = $(ARCH_AMD64)
else ifeq ($(DEB_HOST_ARCH),$(LINUX_ARCH_ARM64_VALUE))
	BUILD_DEB_HOST_ARCH = $(ARCH_ARM64)
else ifeq ($(DEB_HOST_ARCH),$(LINUX_ARCH_ARM_VALUE))
	BUILD_DEB_HOST_ARCH = $(ARCH_ARM)
else ifeq ($(DEB_HOST_ARCH),$(LINUX_ARCH_386_VALUE))
	BUILD_DEB_HOST_ARCH = $(ARCH_386)
endif

DEB_PACK_TYPE ?= source

ifdef ARCH
	ARCH_FLAG_VALUE := $(APP_ARCH)
	ARCH_FOLDER := $(APP_ARCH)
else
	ARCH_FLAG_VALUE := $$(BUILD_DEB_HOST_ARCH)
	ifeq ($(DEB_PACK_TYPE),binary)
		ARCH_FOLDER := $(APP_ARCH)
	else  
		ARCH_FOLDER := all
	endif
endif


ifeq ($(DEB_PACK_TYPE),binary)
	DEB_PACK_DIR = binary/$(ARCH_FOLDER)
else ifeq ($(DEB_PACK_TYPE),source)
	DEB_PACK_DIR = source/$(ARCH_FOLDER)
endif


ifdef GPG_KEY
	GPG_KEY_FLAG := -k$(GPG_KEY)
endif






define arch_to_deb
  $(if $(strip $(1)),\
    $(if $(filter $(ARCH_386),$(1)),i386,\
    $(if $(filter $(ARCH_AMD64),$(1)),amd64,\
    $(if $(filter $(ARCH_ARM64),$(1)),arm64,\
    $(if $(filter $(ARCH_ARM),$(1)),armhf,\
    $(error Unsupported architecture: $(1)))))))
endef
endef

define determine_deb_arch
  $(if $(strip $(ARCH)),\
    $(call arch_to_deb,$(ARCH)),\
    $(if $(filter binary,$(DEB_PACK_TYPE)),\
      $(call arch_to_deb,$(APP_ARCH)),\
      any))
endef

DEB_PACK_ARCH := $(strip $(call determine_deb_arch))


GPG_KEY ?= 
DEB-SERIES ?= "noble"
DEB_PACKAGE_EXT = .deb
DEB_FILES = $(wildcard $(DEB_BUILD_OUTPUT_DIR)/*$(DEB_PACKAGE_EXT))
DEB_RELEASE_DATE_FORMAT := $(shell date -d $(RELEASE_DATE_STD) +"%a, %d %b %Y 00:00:00 +0000")

DEB_BINARY_DIR = usr/bin
DEB_CONFIG_DIR = etc/$(APPLICATION_NAME)
DEB_LOG_DIR = var/log/$(APPLICATION_NAME)
DEB_DATA_DIR = var/lib/$(APPLICATION_NAME)
DEB_DATA_DATABASE_DIR = $(DEB_DATA_DIR)/data
DEB_CACHE_DIR = var/cache/$(APPLICATION_NAME)
DEB_TMP_DIR = var/tmp/$(APPLICATION_NAME)
DEB_LIB_DIR = usr/lib/$(APPLICATION_NAME)
DEB_SHARE_DIR = usr/share/$(APPLICATION_NAME)
DEB_DOCS_DIR = usr/share/doc/$(APPLICATION_NAME)


DEB_ROOT_DIR = $(PACKAGE_ROOT_DIR)/deb
DEB_BUILD_ROOT_DIR = $(DEB_ROOT_DIR)/$(DEB_PACK_DIR)
DEB_BUILD_CONFIG_DIR = $(DEB_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
DEB_BUILD_PAYLOAD_DIR = $(DEB_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
DEB_BUILD_TEMP_DIR = $(DEB_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
DEB_BUILD_OUTPUT_DIR = $(DEB_BUILD_ROOT_DIR)/output
DEB_BUILD_CONFIG_DEBIAN_DIR = $(DEB_BUILD_CONFIG_DIR)/debian


debian-init:
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@mkdir -p $(DEB_BUILD_ROOT_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)
	@mkdir -p $(DEB_BUILD_PAYLOAD_DIR)
	@mkdir -p $(DEB_BUILD_TEMP_DIR)
	@mkdir -p $(DEB_BUILD_OUTPUT_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DEBIAN_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DEBIAN_DIR)/source



debian/control:
	echo "Source: $(APPLICATION_NAME)" > $(DEB_BUILD_CONFIG_DIR)/$@
	# echo "Version: $(APP_TAG)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Section: utils" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Priority: optional" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Maintainer: $(MAINTANER)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Build-Depends: debhelper (>= 12), dh-golang, golang-any" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Standards-Version: 4.5.0" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Homepage: $(HOMEPAGE)" >> $(DEB_BUILD_CONFIG_DIR)/$@

	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Package: $(APPLICATION_NAME)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Architecture: $(DEB_PACK_ARCH)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo 'Depends: $${shlibs:Depends}, $${misc:Depends}, libc6, ca-certificates' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Description: $(DESCRIPTION)" >> $(DEB_BUILD_CONFIG_DIR)/$@

debian/changelog:
	echo "$(APPLICATION_NAME) ($(RAW_VERSION)) $(DEB-SERIES); urgency=medium" > $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	@if [ -f $(CHANGELOG_PATH) ]; then \
		sed 's/^/  /' $(CHANGELOG_PATH) >> $(DEB_BUILD_CONFIG_DIR)/$@; \
	else \
		echo "  * Not specified any changes" >> $(DEB_BUILD_CONFIG_DIR)/$@; \
	fi
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " -- $(MAINTANER)  $(DEB_RELEASE_DATE_FORMAT)" >> $(DEB_BUILD_CONFIG_DIR)/$@


debian/rules:
ifeq ($(DEB_PACK_TYPE),binary)
	echo "#!/usr/bin/make -f" > $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo '%:' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo '	dh $$(DEB_BUILD_CONFIG_DIR)/$@;' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "override_dh_dwz:" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "	true" >> $(DEB_BUILD_CONFIG_DIR)/$@
else ifeq ($(DEB_PACK_TYPE),source)
	echo "#!/usr/bin/make -f" > $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo '%:' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo '	if [ -z "$$(filter $$(MY_TARGETS), $$@)" ]; then \' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo '		dh $$@; \' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo '	else \' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo '		$(MAKE) $$@; \' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo '	fi' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "override_dh_dwz:" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "	true" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "override_dh_auto_build:" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo '	$(MAKE) build.binary.linux.vendor TAG=$(APP_TAG)' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo '	$(MAKE) package.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_FLAG_VALUE)' >> $(DEB_BUILD_CONFIG_DIR)/$@
endif


debian/source/format:
	echo "3.0 (native)" > $(DEB_BUILD_CONFIG_DIR)/$@
	# quilt

debian/copyright:
	echo "Format: http://www.debian.org/doc/packaging-manuals/copyright-format/1.0/" > $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Upstream-Name: $(APPLICATION_FULL_NAME)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Source: $(GIT)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Files: *" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Copyright: 2024, $(MAINTANER)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "License: Apache-2.0" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " The Apache License, Version 2.0, January 2004" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " http://www.apache.org/licenses/LICENSE-2.0" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " On any Redistribution or Use of this Software, including any derivative works," >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " you must include the following notice:" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "     This product includes software developed at" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "     $(ORGANIZATION) $(HOMEPAGE)." >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " You may not use the name of the copyright holder or the name of any contributor" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " to endorse or promote products derived from this Software without specific" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " prior written permission." >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " See the Apache License, Version 2.0 for the full license text." >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Files: debian/*" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "Copyright: 2024, $(OWNER)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "License: Apache-2.0" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " The Apache License, Version 2.0, January 2004" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo " http://www.apache.org/licenses/LICENSE-2.0" >> $(DEB_BUILD_CONFIG_DIR)/$@

debian/compat:
	echo "12" > $(DEB_BUILD_CONFIG_DIR)/$@

debian/install:
	echo "$(DEB_BUILD_CONFIG_DIR)/$(DEB_BINARY_DIR)/$(APP) /$(DEB_BINARY_DIR)/" > $(DEB_BUILD_CONFIG_DIR)/$@

debian/preinst:
	echo "#!/bin/sh" > $(DEB_BUILD_CONFIG_DIR)/$@
	echo "set -e" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo 'echo "Running pre-installation tasks..."' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo 'echo "Pre-installation tasks completed."' >> $(DEB_BUILD_CONFIG_DIR)/$@


debian/postinst:
	echo "#!/bin/sh" > $(DEB_BUILD_CONFIG_DIR)/$@
	echo "set -e" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo 'echo "Running post-installation tasks..."' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "mkdir -p /$(DEB_DATA_DATABASE_DIR)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "chmod -R a+rw /$(DEB_DATA_DATABASE_DIR)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo 'echo "Post-installation tasks completed."' >> $(DEB_BUILD_CONFIG_DIR)/$@


debian/prerm:
	echo "#!/bin/sh" > $(DEB_BUILD_CONFIG_DIR)/$@
	echo "set -e" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo 'echo "Running pre-removal tasks..."' >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo 'echo "Pre-removal tasks completed."' >> $(DEB_BUILD_CONFIG_DIR)/$@

debian/postrm:
	echo "#!/bin/sh" > $(DEB_BUILD_CONFIG_DIR)/$@
	echo "set -e" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo 'echo "Running post-removal tasks..."' >> $(DEB_BUILD_CONFIG_DIR)/$@
	# echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	# echo "# rm -f /etc/$(APPLICATION_NAME)/config.conf" >> $(DEB_BUILD_CONFIG_DIR)/$@
	# echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	# echo "# rmdir /var/lib/$(APPLICATION_NAME)" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo "" >> $(DEB_BUILD_CONFIG_DIR)/$@
	echo 'echo "Post-removal tasks completed."' >> $(DEB_BUILD_CONFIG_DIR)/$@


package.deb.prepare.config: debian-init debian/control debian/changelog debian/rules debian/source/format debian/copyright debian/compat debian/install debian/preinst debian/postinst debian/prerm debian/postrm

