include ./makefiles/modules/package/deb/common.mk


package.deb.binary.prepare.config: DEB_PACK_TYPE = binary
package.deb.binary.prepare.config:
	$(MAKE) package.deb.prepare.config DEB_PACK_TYPE=$(DEB_PACK_TYPE)



package.deb.binary.prepare.payload: DEB_PACK_TYPE = binary
package.deb.binary.prepare.payload:	
	@mkdir -p $(DEB_BUILD_TEMP_DIR)/bn
	@mkdir -p $(DEB_BUILD_TEMP_DIR)/bn/bin
	$(MAKE) build.binary.linux TAG=$(APP_TAG) OS=$(OS_LINUX) ARCH=$(ARCH_FLAG_VALUE) OUTPUT=$(CURDIR)/$(DEB_BUILD_TEMP_DIR)/bn/bin
	cp -r $(DEB_BUILD_TEMP_DIR)/bn/bin $(DEB_BUILD_PAYLOAD_DIR)
	rm -rf $(DEB_BUILD_TEMP_DIR)/bn

package.deb.binary.build:
	@mkdir -p $(DEB_BUILD_OUTPUT_DIR)
	cd $(DEB_BUILD_PAYLOAD_DIR) && dpkg-buildpackage -b $(GPG_KEY_FLAG)
	@echo "Package has been created with version $(APP_TAG)"
	cp -r $(DEB_BUILD_ROOT_DIR)/$(APP)_* $(DEB_BUILD_OUTPUT_DIR)

	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(LINUX_APP_BINARY_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(LINUX_APP_CONFIG_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(LINUX_APP_LOG_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(LINUX_APP_DATA_DATABASE_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(LINUX_APP_CACHE_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(LINUX_APP_LIB_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(LINUX_APP_SHARE_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(LINUX_APP_DOCS_DIR)
	cp -r $(DOCS_USER_DOCS_DIR) $(DEB_BUILD_CONFIG_DIR)/$(LINUX_APP_DOCS_DIR)
	# cp -r $(BIN_ROOT_DIR)/$(APP) $(DEB_BUILD_CONFIG_DIR)/$(LINUX_APP_BINARY_DIR)

#	find $(DEB_PACKAGE_DIR) -maxdepth 1 -name "*.deb" | tar -czvf $(DEB_BUILD_CONFIG_DIR)/$(APPLICATION_NAME)-$(OS_LINUX)-$(APP_ARCH).deb$(TAR_GZ_EXT) -T -
	@echo "Package has been created with version $(APP_TAG)"


# package.deb.compress:

# package.deb.upload.ppa:
