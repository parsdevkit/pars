include ./makefiles/modules/package/rpm/common.mk

package.rpm.source.prepare.config: RPM_PACK_TYPE = source
package.rpm.source.prepare.config:
	$(MAKE) package.rpm.prepare.config RPM_PACK_TYPE=$(RPM_PACK_TYPE)

package.rpm.source.prepare.payload: RPM_PACK_TYPE = source
package.rpm.source.prepare.payload:
	@mkdir -p $(RPM_BUILD_TEMP_DIR)/csp
	cp -r $(SOURCE_ROOT_DIR) $(RPM_BUILD_TEMP_DIR)/csp
	cp -r $(MAKEFILES_ROOT_DIR) $(RPM_BUILD_TEMP_DIR)/csp
	cp -r $(DOCS_ROOT_DIR) $(RPM_BUILD_TEMP_DIR)/csp
	cp $(MAKEFILE_PATH) $(RPM_BUILD_TEMP_DIR)/csp
	chmod +x $(RPM_BUILD_TEMP_DIR)/csp
	cd $(RPM_BUILD_TEMP_DIR)/csp/src && go mod tidy
	cd $(RPM_BUILD_TEMP_DIR)/csp/src && go mod vendor
	tar -czf $(RPM_BUILD_PAYLOAD_DIR)/$(APPLICATION_NAME)-$(RPM_VERSION)$(TAR_GZ_EXT) -C $(RPM_BUILD_TEMP_DIR)/csp ./
	rm -rf $(RPM_BUILD_TEMP_DIR)/csp


package.rpm.source.build:
	@mkdir -p $(RPM_BUILD_OUTPUT_DIR)
	rpmbuild --define "_topdir $(CURDIR)/$(RPM_BUILD_CONFIG_RPM_DIR)" -ba $(RPM_BUILD_CONFIG_SPECS_SPECFILE_PATH)
	@echo "Package has been created with version $(APP_TAG)"
	cp -r $(RPM_BUILD_CONFIG_RPM_DIR)/RPMS/* $(RPM_BUILD_OUTPUT_DIR)
	cp -r $(RPM_BUILD_CONFIG_RPM_DIR)/SRPMS/* $(RPM_BUILD_OUTPUT_DIR)



$(DIST_ARTIFACTS_DIR)/%$(TAR_GZ_EXT): $(RPM_BUILD_OUTPUT_DIR)/%$(RPM_PACKAGE_EXT)
	$(call compress_file,$(RPM_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(TAR_XZ_EXT): $(RPM_BUILD_OUTPUT_DIR)/%$(RPM_PACKAGE_EXT)
	$(call compress_file,$(RPM_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(TAR_BZ2_EXT): $(RPM_BUILD_OUTPUT_DIR)/%$(RPM_PACKAGE_EXT)
	$(call compress_file,$(RPM_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(ZIP_EXT): $(RPM_BUILD_OUTPUT_DIR)/%$(RPM_PACKAGE_EXT)
	$(call compress_file,$(RPM_PACKAGE_EXT))
	
$(DIST_ARTIFACTS_DIR)/%$(RAR_EXT): $(RPM_BUILD_OUTPUT_DIR)/%$(RPM_PACKAGE_EXT)
	$(call compress_file,$(RPM_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(SEVEN_Z_EXT): $(RPM_BUILD_OUTPUT_DIR)/%$(RPM_PACKAGE_EXT)
	$(call compress_file,$(RPM_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(ZST_EXT): $(RPM_BUILD_OUTPUT_DIR)/%$(RPM_PACKAGE_EXT)
	$(call compress_file,$(RPM_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(LZ_EXT): $(RPM_BUILD_OUTPUT_DIR)/%$(RPM_PACKAGE_EXT)
	$(call compress_file,$(RPM_PACKAGE_EXT))


# $(foreach format,$(FORMATS),$(eval $(DIST_ARTIFACTS_DIR)/%$(format): $(RPM_BUILD_OUTPUT_DIR)/%$(RPM_PACKAGE_EXT) ; $(call compress_file,$(RPM_PACKAGE_EXT)) ))
package.rpm.source.create-artifacts: $(addprefix $(DIST_ARTIFACTS_DIR)/, $(foreach format,$(FORMATS),$(notdir $(RPM_FILES:$(RPM_PACKAGE_EXT)=$(format)))))

