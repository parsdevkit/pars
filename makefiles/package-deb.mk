GPG-KEY ?= 
DEB_ROOT_DIR = ./package/$(TAG)/$(OS_LINUX)/deb/$(ARCH)
DEB_DEBIAN_DIR = $(DEB_ROOT_DIR)/debian
DEB_INSTALLATION_DIR = /usr/bin
DEB_INSTALLATION_PATH = $(DEB_INSTALLATION_DIR)/$(APPLICATION_NAME)

debian-init:
	mkdir -p $(DEB_DEBIAN_DIR)

arch-setup:
ifeq ($(ARCH),amd64)
  DEB_ARCH = amd64
else ifeq ($(ARCH),arm64)
  DEB_ARCH = arm64
else ifeq ($(ARCH),arm32)
  DEB_ARCH = armhf
else ifeq ($(ARCH),386)
  DEB_ARCH = i386
else
  $(error Unknown architecture: $(ARCH))
endif

$(info DEB_ARCH is set to $(DEB_ARCH))

debian/control: debian-init arch-setup
	echo "Source: $(APPLICATION_NAME)" > $(DEB_ROOT_DIR)/$@
	# echo "Version: $(TAG)" >> $(DEB_ROOT_DIR)/$@
	echo "Section: utils" >> $(DEB_ROOT_DIR)/$@
	echo "Priority: optional" >> $(DEB_ROOT_DIR)/$@
	echo "Maintainer: $(MAINTANER)" >> $(DEB_ROOT_DIR)/$@
	echo "Build-Depends: debhelper (>= 12)" >> $(DEB_ROOT_DIR)/$@
	echo "Standards-Version: 4.5.0" >> $(DEB_ROOT_DIR)/$@
	echo "Homepage: $(HOMEPAGE)" >> $(DEB_ROOT_DIR)/$@

	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "Package: $(APPLICATION_NAME)" >> $(DEB_ROOT_DIR)/$@
	echo "Architecture: $(DEB_ARCH)" >> $(DEB_ROOT_DIR)/$@
	echo 'Depends: $${shlibs:Depends}, $${misc:Depends}, go' >> $(DEB_ROOT_DIR)/$@
	echo "Description: $(DESCRIPTION)" >> $(DEB_ROOT_DIR)/$@

debian/changelog: debian-init arch-setup
	echo "$(APPLICATION_NAME) ($(TAG)) bionic; urgency=medium" > $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "  * Initial release." >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo " -- $(MAINTANER)  Tue, 21 Aug 2024 00:00:00 +0000" >> $(DEB_ROOT_DIR)/$@

debian/rules: debian-init arch-setup
	echo "#!/usr/bin/make -f" > $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo '%:' >> $(DEB_ROOT_DIR)/$@
	echo '	dh $$@' >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "override_dh_dwz:" >> $(DEB_ROOT_DIR)/$@
	echo "	true" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "override_dh_build:" >> $(DEB_ROOT_DIR)/$@
	echo '	make build TAG=$(TAG) OS=$(OS) ARCH=$(ARCH)' >> $(DEB_ROOT_DIR)/$@
	# echo "" >> $(DEB_ROOT_DIR)/$@
	# echo "override_dh_auto_build:" >> $(DEB_ROOT_DIR)/$@
	# echo '	for mkfile in $(wildcard makefiles/*.mk); do \' >> $(DEB_ROOT_DIR)/$@
	# echo '		$$(MAKE) -f $$$${mkfile}; \' >> $(DEB_ROOT_DIR)/$@
	# echo '	done' >> $(DEB_ROOT_DIR)/$@


debian/format: debian-init arch-setup
	echo "3.0 (native)" > $(DEB_ROOT_DIR)/$@

debian/copyright: debian-init arch-setup
	echo "Format: http://www.debian.org/doc/packaging-manuals/copyright-format/1.0/" > $(DEB_ROOT_DIR)/$@
	echo "Upstream-Name: $(APPLICATION_FULL_NAME)" >> $(DEB_ROOT_DIR)/$@
	echo "Source: $(GIT)" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "Files: *" >> $(DEB_ROOT_DIR)/$@
	echo "Copyright: 2024, $(MAINTANER)" >> $(DEB_ROOT_DIR)/$@
	echo "License: Apache-2.0" >> $(DEB_ROOT_DIR)/$@
	echo " The Apache License, Version 2.0, January 2004" >> $(DEB_ROOT_DIR)/$@
	echo " http://www.apache.org/licenses/LICENSE-2.0" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo " On any Redistribution or Use of this Software, including any derivative works," >> $(DEB_ROOT_DIR)/$@
	echo " you must include the following notice:" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "     This product includes software developed at" >> $(DEB_ROOT_DIR)/$@
	echo "     $(ORGANIZATION) $(HOMEPAGE)." >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo " You may not use the name of the copyright holder or the name of any contributor" >> $(DEB_ROOT_DIR)/$@
	echo " to endorse or promote products derived from this Software without specific" >> $(DEB_ROOT_DIR)/$@
	echo " prior written permission." >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo " See the Apache License, Version 2.0 for the full license text." >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "Files: debian/*" >> $(DEB_ROOT_DIR)/$@
	echo "Copyright: 2024, $(OWNER)" >> $(DEB_ROOT_DIR)/$@
	echo "License: Apache-2.0" >> $(DEB_ROOT_DIR)/$@
	echo " The Apache License, Version 2.0, January 2004" >> $(DEB_ROOT_DIR)/$@
	echo " http://www.apache.org/licenses/LICENSE-2.0" >> $(DEB_ROOT_DIR)/$@

debian/compat: debian-init arch-setup
	echo "12" > $(DEB_ROOT_DIR)/$@

debian/install: debian-init arch-setup
	echo "$(APPLICATION_NAME) $(DEB_INSTALLATION_DIR)/" > $(DEB_ROOT_DIR)/$@

debian/preinst: debian-init arch-setup
	echo "#!/bin/sh" > $(DEB_ROOT_DIR)/$@
	echo "set -e" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo 'echo "Running pre-installation tasks..."' >> $(DEB_ROOT_DIR)/$@
	echo "if [ ! -L $(DEB_INSTALLATION_PATH) ]; then" >> $(DEB_ROOT_DIR)/$@
	echo '    echo "Warning: /usr/bin/pars already exists. It will be overwritten."' >> $(DEB_ROOT_DIR)/$@
	echo "fi" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo 'echo "Pre-installation tasks completed."' >> $(DEB_ROOT_DIR)/$@


debian/postinst: debian-init arch-setup
	echo "#!/bin/sh" > $(DEB_ROOT_DIR)/$@
	echo "set -e" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo 'echo "Running post-installation tasks..."' >> $(DEB_ROOT_DIR)/$@
	echo "if [ ! -L $(DEB_INSTALLATION_PATH) ]; then" >> $(DEB_ROOT_DIR)/$@
	echo "    ln -s $(DEB_INSTALLATION_PATH) $(DEB_INSTALLATION_PATH)" >> $(DEB_ROOT_DIR)/$@
	echo "fi" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "# systemctl enable $(APPLICATION_NAME)" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo 'echo "Post-installation tasks completed."' >> $(DEB_ROOT_DIR)/$@


debian/prerm: debian-init arch-setup
	echo "#!/bin/sh" > $(DEB_ROOT_DIR)/$@
	echo "set -e" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo 'echo "Running pre-removal tasks..."' >> $(DEB_ROOT_DIR)/$@
	echo "if [ ! -L $(DEB_INSTALLATION_PATH) ]; then" >> $(DEB_ROOT_DIR)/$@
	echo "    rm $(DEB_INSTALLATION_PATH) $(DEB_INSTALLATION_PATH)" >> $(DEB_ROOT_DIR)/$@
	echo "fi" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "# systemctl stop $(APPLICATION_NAME)" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo 'echo "Pre-removal tasks completed."' >> $(DEB_ROOT_DIR)/$@

debian/postrm: debian-init arch-setup
	echo "#!/bin/sh" > $(DEB_ROOT_DIR)/$@
	echo "set -e" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo 'echo "Running post-removal tasks..."' >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "# rm -f /etc/$(APPLICATION_NAME)/config.conf" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo "# rmdir /var/lib/$(APPLICATION_NAME)" >> $(DEB_ROOT_DIR)/$@
	echo "" >> $(DEB_ROOT_DIR)/$@
	echo 'echo "Post-removal tasks completed."' >> $(DEB_ROOT_DIR)/$@


debian-files: debian/control debian/changelog debian/rules debian/format debian/copyright debian/compat debian/install debian/preinst debian/postinst debian/prerm debian/postrm

debian-package: debian-files
	# cp $(BIN_ROOT_DIR)/$(TARGET) $(DEB_ROOT_DIR)
	cd $(DEB_ROOT_DIR) && dpkg-buildpackage -k$(GPG-KEY) -b
	@echo "Package has been created with version $(TAG)"
