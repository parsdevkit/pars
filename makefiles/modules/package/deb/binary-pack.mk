include ./makefiles/modules/package/deb/common.mk


# DEB_PACKAGE_DIR = $(DEB_BUILD_CONFIG_DIR)/package

package.deb.binary.prepare: DEB_PACK_TYPE = binary
package.deb.binary.prepare:
	$(MAKE) package.deb.prepare DEB_PACK_TYPE=$(DEB_PACK_TYPE)

package.deb.binary.build:
# package.deb.build.binary: $(DEB_PACK_TYPE)/debian-files

#	# @mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_BINARY_DIR)
#	# @mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_CONFIG_DIR)
#	# @mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_LOG_DIR)
#	# @mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_DATA_DATABASE_DIR)
#	# @mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_CACHE_DIR)
#	# @mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_LIB_DIR)
#	# @mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_SHARE_DIR)
#	# @mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_DOCS_DIR)
#	# $(MAKE) build.binary.linux TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_386)
#	# cp -r $(BIN_ROOT_DIR)/$(APP) $(DEB_BUILD_CONFIG_DIR)/$(DEB_BINARY_DIR)
#	# cp -r $(DOCS_USER_DOCS_DIR) $(DEB_BUILD_CONFIG_DIR)/$(DEB_DOCS_DIR)
#
#	# cd $(DEB_BUILD_CONFIG_DIR) && dpkg-buildpackage -b $(GPG_KEY_FLAG)
#	# find $(DEB_PACKAGE_DIR) -maxdepth 1 -name "*.deb" | tar -czvf $(DEB_BUILD_CONFIG_DIR)/$(APPLICATION_NAME)-$(OS_LINUX)-$(APP_ARCH).deb.tar.gz -T -
#	# @echo "Package has been created with version $(APP_TAG)"


# package.deb.compress:

# package.deb.upload.ppa:
