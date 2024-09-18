include ./makefiles/variables.mk
include ./makefiles/init.mk

RPM_PACK_TYPE ?= source
define determine_arch_flag_value
  $(if $(strip $(ARCH)),$(APP_ARCH),)
endef
ARCH_FLAG_VALUE := $(strip $(call determine_arch_flag_value))

define determine_arch_folder
  $(if $(strip $(ARCH)),$(APP_ARCH),\
    $(if $(filter binary,$(RPM_PACK_TYPE)),$(APP_ARCH),all))
endef
ARCH_FOLDER := $(strip $(call determine_arch_folder))


define determine_rpm_pack_dir
  $(if $(filter binary,$(RPM_PACK_TYPE)),\
    binary/$(ARCH_FOLDER),\
    $(if $(filter source,$(RPM_PACK_TYPE)),\
      source/$(ARCH_FOLDER),\
      $(error Unsupported RPM_PACK_TYPE: $(RPM_PACK_TYPE))))
endef

RPM_PACK_DIR := $(strip $(call determine_rpm_pack_dir))

define determine_gpg_key_flag
  $(if $(strip $(GPG_KEY)),-k$(GPG_KEY))
endef

GPG_KEY_FLAG := $(strip $(call determine_gpg_key_flag))



define arch_to_rpm
  $(if $(strip $(1)),\
    $(if $(filter $(ARCH_386),$(1)),i386,\
    $(if $(filter $(ARCH_AMD64),$(1)),x86_64,\
    $(if $(filter $(ARCH_ARM64),$(1)),aarch64,\
    $(if $(filter $(ARCH_ARM),$(1)),armhfp,\
    $(error Unsupported architecture: $(1)))))))
endef

define determine_rpm_arch
  $(if $(strip $(ARCH)),\
    $(call arch_to_rpm,$(ARCH)),\
    $(if $(filter binary,$(RPM_PACK_TYPE)),\
      $(call arch_to_rpm,$(APP_ARCH)),\
      %{?_arch}))
endef
RPM_PACK_ARCH := $(strip $(call determine_rpm_arch))

GPG_KEY ?= 
RPM-SERIES ?= "noble"
RPM_PACKAGE_EXT = .rpm
RPM_FILES = $(wildcard $(RPM_BUILD_OUTPUT_DIR)/*$(RPM_PACKAGE_EXT))

RPM_BINARY_DIR = usr/bin
RPM_CONFIG_DIR = etc/$(APPLICATION_NAME)
RPM_LOG_DIR = var/log/$(APPLICATION_NAME)
RPM_DATA_DIR = var/lib/$(APPLICATION_NAME)
RPM_DATA_DATABASE_DIR = $(RPM_DATA_DIR)/data
RPM_CACHE_DIR = var/cache/$(APPLICATION_NAME)
RPM_TMP_DIR = var/tmp/$(APPLICATION_NAME)
RPM_LIB_DIR = usr/lib/$(APPLICATION_NAME)
RPM_SHARE_DIR = usr/share/$(APPLICATION_NAME)
RPM_DOCS_DIR = usr/share/doc/$(APPLICATION_NAME)


RPM_ROOT_DIR = $(PACKAGE_ROOT_DIR)/rpm
RPM_BUILD_ROOT_DIR = $(RPM_ROOT_DIR)/$(RPM_PACK_DIR)
RPM_BUILD_CONFIG_DIR = $(RPM_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
RPM_BUILD_PAYLOAD_DIR = $(RPM_BUILD_CONFIG_RPM_DIR)/SOURCES
RPM_BUILD_TEMP_DIR = $(RPM_BUILD_ROOT_DIR)/$(APPLICATION_NAME)/tmp
RPM_BUILD_OUTPUT_DIR = $(RPM_BUILD_ROOT_DIR)/output
RPM_BUILD_CONFIG_RPM_DIR = $(RPM_BUILD_CONFIG_DIR)/rpmbuild
RPM_BUILD_CONFIG_SPECS_SPECFILE_PATH = $(RPM_BUILD_CONFIG_DIR)/rpmbuild/SPECS/$(APPLICATION_NAME).spec


APP_TAG_CLEAN=${APP_TAG#v}
RPM_VERSION := $(shell echo $(APP_TAG) | sed 's/^v//' | cut -d'-' -f1)
RPM_RELEASE := $(shell echo $(APP_TAG) | sed 's/^v//' | cut -d'-' -f2-)
RPM_RELEASE_DATE_FORMAT := $(shell date -d $(RELEASE_DATE_STD) +"%a %b %d %Y")



rpm-init:
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@mkdir -p $(RPM_BUILD_TEMP_DIR)
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/BUILD
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/RPMS
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/SOURCES
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/SPECS
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/SRPMS



rpmbuild/SPECS/$(APPLICATION_NAME).spec:
	echo "Name: $(APPLICATION_NAME)" > $(RPM_BUILD_CONFIG_DIR)/$@
	echo "Version: $(RPM_VERSION)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "Release: $(RPM_RELEASE)%{?dist}" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "Summary: $(SUMMARY)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "License: $(LICENCE_TYPE)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "URL: $(HOMEPAGE)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "Source0: %{name}-%{version}.tar.gz" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "BuildArch: $(RPM_PACK_ARCH)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
#	echo "BuildRequires: " >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "Requires: glibc" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "%description" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "$(DESCRIPTION)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "%prep" >> $(RPM_BUILD_CONFIG_DIR)/$@
#	echo "%setup -q" >> $(RPM_BUILD_CONFIG_DIR)/$@
#	echo "mkdir -p %{_builddir}/%{name}-%{version}" >> $(RPM_BUILD_CONFIG_DIR)/$@
#	echo "tar -xzf %{SOURCE0} -C %{_builddir}/%{name}-%{version}" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "tar -xzf %{SOURCE0} -C %{_builddir}" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "%build" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "$(MAKE) build.binary.linux.vendor TAG=$(APP_TAG)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "echo %{buildroot} " >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "%install" >> $(RPM_BUILD_CONFIG_DIR)/$@
#	echo "$(MAKE) package.rpm.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_FLAG_VALUE)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "mkdir -p %{buildroot}/$(RPM_BINARY_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "mkdir -p %{buildroot}/$(RPM_DOCS_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "cp -r $(BIN_ROOT_DIR)/output/$(APP) %{buildroot}/$(RPM_BINARY_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "cp -r $(DOCS_USER_DOCS_DIR) %{buildroot}/$(RPM_DOCS_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "%files" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "%{_bindir}/$(APPLICATION_NAME)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "/$(RPM_DOCS_DIR)/*" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "%changelog" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "* $(RPM_RELEASE_DATE_FORMAT) $(MAINTANER) - $(APP_TAG)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	@if [ -f $(CHANGELOG_PATH) ]; then \
		sed 's/^\*/-/' $(CHANGELOG_PATH) >> $(RPM_BUILD_CONFIG_DIR)/$@; \
	else \
		echo "- Not specified any changes" >> $(RPM_BUILD_CONFIG_DIR)/$@; \
	fi



package.rpm.prepare.config: rpm-init rpmbuild/SPECS/$(APPLICATION_NAME).spec

