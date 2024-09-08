include ./makefiles/modules/package/deb/common.mk

DEB_SOURCE_ROOT_DIR = $(DEB_ROOT_DIR)/source
DEB_SOURCE_ROOT_PACKAGE_DIR = $(DEB_SOURCE_ROOT_DIR)/package
DEB_SOURCE_ROOT_SOURCE_DIR = $(DEB_SOURCE_ROOT_DIR)/source
DEB_BASE_DIR = $(DEB_SOURCE_ROOT_DIR)/$(APPLICATION_NAME)
DEB_DEBIAN_DIR = $(DEB_BASE_DIR)/debian
DEB_CONTROL_FILE_PATH = $(DEB_DEBIAN_DIR)/control
DEB_CHANGELOG_FILE_PATH = $(DEB_DEBIAN_DIR)/changelog
DEB_RULES_FILE_PATH = $(DEB_DEBIAN_DIR)/rules
DEB_SOURCE_FORMAT_FILE_PATH = $(DEB_DEBIAN_DIR)/source/format
DEB_COPYRIGHT_FILE_PATH = $(DEB_DEBIAN_DIR)/copyright
DEB_COMPAT_FILE_PATH = $(DEB_DEBIAN_DIR)/compat
DEB_INSTALL_FILE_PATH = $(DEB_DEBIAN_DIR)/install
DEB_PREINST_FILE_PATH = $(DEB_DEBIAN_DIR)/preinst
DEB_POSTINT_FILE_PATH = $(DEB_DEBIAN_DIR)/postinst
DEB_PRERM_FILE_PATH = $(DEB_DEBIAN_DIR)/prerm
DEB_POSTRM_FILE_PATH = $(DEB_DEBIAN_DIR)/postrm


binary/debian-init:
	@mkdir -p $(DEB_DEBIAN_DIR)
	@mkdir -p $(DEB_DEBIAN_DIR)/source

source/debian/control:
	echo "Source: $(APPLICATION_NAME)" > $(DEB_CONTROL_FILE_PATH)
	# echo "Version: $(APP_TAG)" >> $(DEB_CONTROL_FILE_PATH)
	echo "Section: utils" >> $(DEB_CONTROL_FILE_PATH)
	echo "Priority: optional" >> $(DEB_CONTROL_FILE_PATH)
	echo "Maintainer: $(MAINTANER)" >> $(DEB_CONTROL_FILE_PATH)
	echo "Build-Depends: debhelper (>= 12), golang-go" >> $(DEB_CONTROL_FILE_PATH)
	echo "Standards-Version: 4.5.0" >> $(DEB_CONTROL_FILE_PATH)
	echo "Homepage: $(HOMEPAGE)" >> $(DEB_CONTROL_FILE_PATH)

	echo "" >> $(DEB_CONTROL_FILE_PATH)
	echo "Package: $(APPLICATION_NAME)" >> $(DEB_CONTROL_FILE_PATH)
	echo "Architecture: any" >> $(DEB_CONTROL_FILE_PATH)
	echo 'Depends: $${shlibs:Depends}, $${misc:Depends}, libc6, ca-certificates' >> $(DEB_CONTROL_FILE_PATH)
	echo "Description: $(DESCRIPTION)" >> $(DEB_CONTROL_FILE_PATH)

source/debian/changelog:
	echo "$(APPLICATION_NAME) ($(RAW_VERSION)) $(DEB-SERIES); urgency=medium" > $(DEB_CHANGELOG_FILE_PATH)
	echo "" >> $(DEB_CHANGELOG_FILE_PATH)
	@if [ -f $(CHANGELOG_PATH) ]; then \
		sed 's/^/  /' $(CHANGELOG_PATH) >> $(DEB_CHANGELOG_FILE_PATH); \
	else \
		echo "  * Not specified any changes" >> $(DEB_CHANGELOG_FILE_PATH); \
	fi
	echo "" >> $(DEB_CHANGELOG_FILE_PATH)
	echo " -- $(MAINTANER)  $(RELEASE_DATE)" >> $(DEB_CHANGELOG_FILE_PATH)


source/debian/rules:
	echo "#!/usr/bin/make -f" > $(DEB_RULES_FILE_PATH)
	echo "" >> $(DEB_RULES_FILE_PATH)
	echo '%:' >> $(DEB_RULES_FILE_PATH)
	echo '	if [ -z "$$(filter $$(MY_TARGETS), $$@)" ]; then \' >> $(DEB_RULES_FILE_PATH)
	echo '		dh $$@; \' >> $(DEB_RULES_FILE_PATH)
	echo '	else \' >> $(DEB_RULES_FILE_PATH)
	echo '		$(MAKE) $$@; \' >> $(DEB_RULES_FILE_PATH)
	echo '	fi' >> $(DEB_RULES_FILE_PATH)
	echo "" >> $(DEB_RULES_FILE_PATH)
	echo "" >> $(DEB_RULES_FILE_PATH)
	echo "" >> $(DEB_RULES_FILE_PATH)
	echo "override_dh_dwz:" >> $(DEB_RULES_FILE_PATH)
	echo "	true" >> $(DEB_RULES_FILE_PATH)
	echo "" >> $(DEB_RULES_FILE_PATH)
	echo "override_dh_auto_build:" >> $(DEB_RULES_FILE_PATH)
	
	echo 'ifeq ($$(DEB_HOST_ARCH), i386)' >> $(DEB_RULES_FILE_PATH)
# Burda debian-binary-package kullanıbilir?
	echo '	$(MAKE) build.binary.linux.vendor TAG=$(APP_TAG) ARCH=$(APP_ARCH)' >> $(DEB_RULES_FILE_PATH)
	echo '	$(MAKE) package.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(APP_ARCH)' >> $(DEB_RULES_FILE_PATH)
	echo "endif" >> $(DEB_RULES_FILE_PATH)
	
	echo 'ifeq ($$(DEB_HOST_ARCH), amd64)' >> $(DEB_RULES_FILE_PATH)
# Burda debian-binary-package kullanıbilir?
	echo '	$(MAKE) build.binary.linux.vendor TAG=$(APP_TAG) ARCH=$(APP_ARCH)' >> $(DEB_RULES_FILE_PATH)
	echo '	$(MAKE) package.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(APP_ARCH)' >> $(DEB_RULES_FILE_PATH)
	echo "endif" >> $(DEB_RULES_FILE_PATH)
	
	echo 'ifeq ($$(DEB_HOST_ARCH), armhf)' >> $(DEB_RULES_FILE_PATH)
# Burda debian-binary-package kullanıbilir?
	echo '	$(MAKE) build.binary.linux.vendor TAG=$(APP_TAG) ARCH=$(APP_ARCH)' >> $(DEB_RULES_FILE_PATH)
	echo '	$(MAKE) package.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(APP_ARCH)' >> $(DEB_RULES_FILE_PATH)
	echo "endif" >> $(DEB_RULES_FILE_PATH)
	
	echo 'ifeq ($$(DEB_HOST_ARCH), arm64)' >> $(DEB_RULES_FILE_PATH)
# Burda debian-binary-package kullanıbilir?
	echo '	$(MAKE) build.binary.linux.vendor TAG=$(APP_TAG) ARCH=$(APP_ARCH)' >> $(DEB_RULES_FILE_PATH)
	echo '	$(MAKE) package.move-binary-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(APP_ARCH)' >> $(DEB_RULES_FILE_PATH)
	echo "endif" >> $(DEB_RULES_FILE_PATH)



source/debian/source/format:
	echo "3.0 (native)" > $(DEB_SOURCE_FORMAT_FILE_PATH)
	# quilt

source/debian/copyright:
	echo "Format: http://www.debian.org/doc/packaging-manuals/copyright-format/1.0/" > $(DEB_COPYRIGHT_FILE_PATH)
	echo "Upstream-Name: $(APPLICATION_FULL_NAME)" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "Source: $(GIT)" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "Files: *" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "Copyright: 2024, $(MAINTANER)" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "License: Apache-2.0" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo " The Apache License, Version 2.0, January 2004" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo " http://www.apache.org/licenses/LICENSE-2.0" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo " On any Redistribution or Use of this Software, including any derivative works," >> $(DEB_COPYRIGHT_FILE_PATH)
	echo " you must include the following notice:" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "     This product includes software developed at" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "     $(ORGANIZATION) $(HOMEPAGE)." >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo " You may not use the name of the copyright holder or the name of any contributor" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo " to endorse or promote products derived from this Software without specific" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo " prior written permission." >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo " See the Apache License, Version 2.0 for the full license text." >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "Files: debian/*" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "Copyright: 2024, $(OWNER)" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo "License: Apache-2.0" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo " The Apache License, Version 2.0, January 2004" >> $(DEB_COPYRIGHT_FILE_PATH)
	echo " http://www.apache.org/licenses/LICENSE-2.0" >> $(DEB_COPYRIGHT_FILE_PATH)

source/debian/compat:
	echo "12" > $(DEB_COMPAT_FILE_PATH)

source/debian/install:
	echo "$(DEB_BASE_DIR)/$(APP) $(DEB_INSTALLATION_DIR)/" > $(DEB_INSTALL_FILE_PATH)

source/debian/preinst:
	echo "#!/bin/sh" > $(DEB_PREINST_FILE_PATH)
	echo "set -e" >> $(DEB_PREINST_FILE_PATH)
	echo "" >> $(DEB_PREINST_FILE_PATH)
	echo 'echo "Running pre-installation tasks..."' >> $(DEB_PREINST_FILE_PATH)
	echo "if [ ! -L $(DEB_INSTALLATION_PATH) ]; then" >> $(DEB_PREINST_FILE_PATH)
	echo '    echo "Warning: $(DEB_INSTALLATION_PATH) already exists. It will be overwritten."' >> $(DEB_PREINST_FILE_PATH)
	echo "fi" >> $(DEB_PREINST_FILE_PATH)
	echo "" >> $(DEB_PREINST_FILE_PATH)
	echo 'echo "Pre-installation tasks completed."' >> $(DEB_PREINST_FILE_PATH)


source/debian/postinst:
	echo "#!/bin/sh" > $(DEB_POSTINT_FILE_PATH)
	echo "set -e" >> $(DEB_POSTINT_FILE_PATH)
	echo "" >> $(DEB_POSTINT_FILE_PATH)
	echo 'echo "Running post-installation tasks..."' >> $(DEB_POSTINT_FILE_PATH)
	echo "if [ ! -L $(DEB_INSTALLATION_PATH) ]; then" >> $(DEB_POSTINT_FILE_PATH)
	echo "    ln -s $(DEB_INSTALLATION_PATH) $(DEB_INSTALLATION_PATH)" >> $(DEB_POSTINT_FILE_PATH)
	echo "fi" >> $(DEB_POSTINT_FILE_PATH)
	echo "" >> $(DEB_POSTINT_FILE_PATH)
	echo "# systemctl enable $(APPLICATION_NAME)" >> $(DEB_POSTINT_FILE_PATH)
	echo "" >> $(DEB_POSTINT_FILE_PATH)
	echo 'echo "Post-installation tasks completed."' >> $(DEB_POSTINT_FILE_PATH)


source/debian/prerm:
	echo "#!/bin/sh" > $(DEB_PRERM_FILE_PATH)
	echo "set -e" >> $(DEB_PRERM_FILE_PATH)
	echo "" >> $(DEB_PRERM_FILE_PATH)
	echo 'echo "Running pre-removal tasks..."' >> $(DEB_PRERM_FILE_PATH)
	echo "if [ ! -L $(DEB_INSTALLATION_PATH) ]; then" >> $(DEB_PRERM_FILE_PATH)
	echo "    rm $(DEB_INSTALLATION_PATH) $(DEB_INSTALLATION_PATH)" >> $(DEB_PRERM_FILE_PATH)
	echo "fi" >> $(DEB_PRERM_FILE_PATH)
	echo "" >> $(DEB_PRERM_FILE_PATH)
	echo "# systemctl stop $(APPLICATION_NAME)" >> $(DEB_PRERM_FILE_PATH)
	echo "" >> $(DEB_PRERM_FILE_PATH)
	echo 'echo "Pre-removal tasks completed."' >> $(DEB_PRERM_FILE_PATH)

source/debian/postrm:
	echo "#!/bin/sh" > $(DEB_POSTRM_FILE_PATH)
	echo "set -e" >> $(DEB_POSTRM_FILE_PATH)
	echo "" >> $(DEB_POSTRM_FILE_PATH)
	echo 'echo "Running post-removal tasks..."' >> $(DEB_POSTRM_FILE_PATH)
	echo "" >> $(DEB_POSTRM_FILE_PATH)
	echo "# rm -f /etc/$(APPLICATION_NAME)/config.conf" >> $(DEB_POSTRM_FILE_PATH)
	echo "" >> $(DEB_POSTRM_FILE_PATH)
	echo "# rmdir /var/lib/$(APPLICATION_NAME)" >> $(DEB_POSTRM_FILE_PATH)
	echo "" >> $(DEB_POSTRM_FILE_PATH)
	echo 'echo "Post-removal tasks completed."' >> $(DEB_POSTRM_FILE_PATH)


source/debian-files: binary/debian-init source/debian/control source/debian/changelog source/debian/rules source/debian/source/format source/debian/copyright source/debian/compat source/debian/install source/debian/preinst source/debian/postinst source/debian/prerm source/debian/postrm



package.deb.build.source: source/debian-files
ifdef GPG_KEY
	PACKAGE_KEY := -k$(GPG_KEY)
endif
	$(MAKE) package.move-source-code-to-package-source TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(APP_ARCH)
	cd $(DEB_BASE_DIR)/src && go mod vendor
	cd $(DEB_BASE_DIR) && dpkg-buildpackage -S $(PACKAGE_KEY)
	@echo "Package has been created with version $(APP_TAG)"

package.deb.push-ppa:
	gpg --verify  $(DEB_SOURCE_ROOT_DIR)/*.changes
	dput ppa:$(PPA) $(DEB_SOURCE_ROOT_DIR)/*.changes
	@echo "Package has been pushed to $(PPA) with version $(APP_TAG)"




package.move-binary-to-package-source:
	@mkdir -p $(DEB_BASE_DIR)
	cp -r $(BIN_ARTIFACTS_DIR)/$(APP) $(DEB_BASE_DIR)

package.move-source-code-to-package-source:
	cp -r $(ROOT_DIR)/src $(DEB_BASE_DIR)
	cp -r $(ROOT_DIR)/makefiles $(DEB_BASE_DIR)
	cp $(ROOT_DIR)/Makefile $(DEB_BASE_DIR)/Makefile
	chmod +x $(DEB_BASE_DIR)

