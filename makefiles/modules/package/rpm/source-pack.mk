include ./makefiles/modules/package/rpm/common.mk

package.rpm.source.prepare.config: RPM_PACK_TYPE = source
package.rpm.source.prepare.config:
	$(MAKE) package.rpm.prepare.config RPM_PACK_TYPE=$(RPM_PACK_TYPE)

package.rpm.source.prepare.payload: RPM_PACK_TYPE = source
# package.rpm.source.prepare.payload: copy-source-to-payload
# package.rpm.source.prepare.payload: install-source-on-payload
package.rpm.source.prepare.payload: copy-source-to-payload install-source-on-payload

copy-source-to-payload:	
	@mkdir -p $(RPM_BUILD_TEMP_DIR)/csp
	cp -r $(SOURCE_ROOT_DIR) $(RPM_BUILD_TEMP_DIR)/csp
	cp -r $(MAKEFILES_ROOT_DIR) $(RPM_BUILD_TEMP_DIR)/csp
	cp -r $(DOCS_ROOT_DIR) $(RPM_BUILD_TEMP_DIR)/csp
	cp $(MAKEFILE_PATH) $(RPM_BUILD_TEMP_DIR)/csp
	chmod +x $(RPM_BUILD_TEMP_DIR)/csp

install-source-on-payload:
	cd $(RPM_BUILD_TEMP_DIR)/csp/src && go mod tidy
	cd $(RPM_BUILD_TEMP_DIR)/csp/src && go mod vendor
	tar -czf $(RPM_BUILD_PAYLOAD_DIR)/$(APPLICATION_NAME)-$(RPM_VERSION)$(TAR_GZ_EXT) -C $(RPM_BUILD_TEMP_DIR)/csp ./
	rm -rf $(RPM_BUILD_TEMP_DIR)/csp


build-package:
	rpmbuild --define "_topdir $(CURDIR)/$(RPM_BUILD_CONFIG_RPM_DIR)" -ba $(RPM_BUILD_CONFIG_SPECS_SPECFILE_PATH)
	@echo "Package has been created with version $(APP_TAG)"

package.rpm.source.build: package.rpm.source/prepare-output build-package package.rpm.source/move-outputs
# package.rpm.source.build: package.rpm.source/move-outputs


package.rpm.source/prepare-output:
	@mkdir -p $(RPM_BUILD_OUTPUT_DIR)

package.rpm.source/move-outputs:
	cp -r $(RPM_BUILD_CONFIG_RPM_DIR)/RPMS/* $(RPM_BUILD_OUTPUT_DIR)
	cp -r $(RPM_BUILD_CONFIG_RPM_DIR)/SRPMS/* $(RPM_BUILD_OUTPUT_DIR)




BIN_BUILD_ROOT_DIR = $(BIN_ROOT_DIR)
BIN_BUILD_OUTPUT_DIR = $(BIN_BUILD_ROOT_DIR)/output

package.rpm.move-binary-to-package-source:
	@mkdir -p %{buildroot}/$(RPM_BINARY_DIR)
	@mkdir -p %{buildroot}/$(RPM_CONFIG_DIR)
	@mkdir -p %{buildroot}/$(RPM_LOG_DIR)
	@mkdir -p %{buildroot}/$(RPM_DATA_DATABASE_DIR)
	@mkdir -p %{buildroot}/$(RPM_CACHE_DIR)
	@mkdir -p %{buildroot}/$(RPM_LIB_DIR)
	@mkdir -p %{buildroot}/$(RPM_SHARE_DIR)
	@mkdir -p %{buildroot}/$(RPM_DOCS_DIR)
	cp -r $(BIN_BUILD_OUTPUT_DIR)/$(APP) %{buildroot}/$(RPM_BINARY_DIR)
	cp -r $(DOCS_USER_DOCS_DIR) %{buildroot}/$(RPM_DOCS_DIR)








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

