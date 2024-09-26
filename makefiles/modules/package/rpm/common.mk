include ./makefiles/variables.mk
include ./makefiles/init.mk


RPM_PACK_TYPE ?= source
ARCH_FLAG_VALUE := $(strip $(call determine_arch_flag_value))
ARCH_FOLDER := $(strip $(call determine_arch_folder,$(RPM_PACK_TYPE)))
PACK_ROOT_DIR := $(strip $(call determine_pack_dir,$(RPM_PACK_TYPE)))

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
    $(if $(filter binary,$(1)),\
      $(call arch_to_rpm,$(APP_ARCH)),\
      %{?_arch}))
endef
RPM_PACK_ARCH := $(strip $(call determine_rpm_arch,$(RPM_PACK_TYPE)))



RPM_PACKAGE_EXT = .rpm
RPM_ROOT_DIR = $(PACKAGE_ROOT_DIR)/rpm
RPM_BUILD_ROOT_DIR = $(RPM_ROOT_DIR)/$(PACK_ROOT_DIR)
RPM_BUILD_CONFIG_DIR = $(RPM_BUILD_ROOT_DIR)/$(APPLICATION_NAME)
RPM_BUILD_PAYLOAD_DIR = $(RPM_BUILD_CONFIG_RPM_DIR)/SOURCES
RPM_BUILD_OUTPUT_DIR = $(RPM_BUILD_ROOT_DIR)/output
RPM_BUILD_TEMP_DIR = $(RPM_BUILD_ROOT_DIR)/tmp
RPM_BUILD_OUTPUT_RPM_FILES = $(wildcard $(RPM_BUILD_OUTPUT_DIR)/*$(RPM_PACKAGE_EXT))
RPM_BUILD_CONFIG_RPM_DIR = $(RPM_BUILD_CONFIG_DIR)/rpmbuild
RPM_BUILD_CONFIG_SPECS_SPECFILE_PATH = $(RPM_BUILD_CONFIG_DIR)/rpmbuild/SPECS/$(APPLICATION_NAME).spec


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
	echo "Version: $(APP_TAG_VERSION)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "Release: $(APP_TAG_RELEASE)%{?dist}" >> $(RPM_BUILD_CONFIG_DIR)/$@
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
	echo "mkdir -p %{buildroot}/$(LINUX_APP_BINARY_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "mkdir -p %{buildroot}/$(LINUX_APP_CONFIG_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "mkdir -p %{buildroot}/$(LINUX_APP_LOG_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "mkdir -p %{buildroot}/$(LINUX_APP_DATA_DATABASE_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "mkdir -p %{buildroot}/$(LINUX_APP_CACHE_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "mkdir -p %{buildroot}/$(LINUX_APP_LIB_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "mkdir -p %{buildroot}/$(LINUX_APP_SHARE_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "mkdir -p %{buildroot}/$(LINUX_APP_DOCS_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "cp -r $(BIN_ROOT_DIR)/output/$(APP) %{buildroot}/$(LINUX_APP_BINARY_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "cp -r $(DOCS_USER_DOCS_DIR) %{buildroot}/$(LINUX_APP_DOCS_DIR)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "%files" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "%{_bindir}/$(APPLICATION_NAME)" >> $(RPM_BUILD_CONFIG_DIR)/$@
	echo "/$(LINUX_APP_DOCS_DIR)/*" >> $(RPM_BUILD_CONFIG_DIR)/$@
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

