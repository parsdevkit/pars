include ./makefiles/modules/package/msi/common.mk

package.msi.source.prepare.config: MSI_PACK_TYPE = source
package.msi.source.prepare.config:
	$(MAKE) package.msi.prepare.config MSI_PACK_TYPE=$(MSI_PACK_TYPE)

package.msi.source.prepare.payload: MSI_PACK_TYPE = source
package.msi.source.prepare.payload:
	@mkdir -p $(MSI_BUILD_TEMP_DIR)/csp
	cp -r $(SOURCE_ROOT_DIR) $(MSI_BUILD_TEMP_DIR)/csp
	cp -r $(MAKEFILES_ROOT_DIR) $(MSI_BUILD_TEMP_DIR)/csp
	cp -r $(DOCS_ROOT_DIR) $(MSI_BUILD_TEMP_DIR)/csp
	cp $(MAKEFILE_PATH) $(MSI_BUILD_TEMP_DIR)/csp
	chmod +x $(MSI_BUILD_TEMP_DIR)/csp
	cd $(MSI_BUILD_TEMP_DIR)/csp/src && go mod tidy
	cd $(MSI_BUILD_TEMP_DIR)/csp/src && go mod vendor
	tar -czf $(MSI_BUILD_PAYLOAD_DIR)/$(APPLICATION_NAME)-$(APP_TAG_VERSION)$(TAR_GZ_EXT) -C $(MSI_BUILD_TEMP_DIR)/csp ./
	rm -rf $(MSI_BUILD_TEMP_DIR)/csp


package.msi.source.build:
	@mkdir -p $(MSI_BUILD_OUTPUT_DIR)
	msibuild --define "_topdir $(CURDIR)/$(MSI_BUILD_CONFIG_MSI_DIR)" -ba $(MSI_BUILD_CONFIG_SPECS_SPECFILE_PATH)
	@echo "Package has been created with version $(APP_TAG)"
#	cp -r $(MSI_BUILD_CONFIG_MSI_DIR)/* $(MSI_BUILD_OUTPUT_DIR)



