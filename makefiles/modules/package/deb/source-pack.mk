include ./makefiles/modules/package/deb/common.mk

package.deb.source.prepare.config: DEB_PACK_TYPE = source
package.deb.source.prepare.config:
	$(MAKE) package.deb.prepare.config DEB_PACK_TYPE=$(DEB_PACK_TYPE)

package.deb.source.prepare.payload: DEB_PACK_TYPE = source
package.deb.source.prepare.payload: copy-source-to-payload
# package.deb.source.prepare.payload: install-source-on-payload
# package.deb.source.prepare.payload: copy-source-to-payload install-source-on-payload

copy-source-to-payload:
	cp -r $(SOURCE_ROOT_DIR) $(DEB_BUILD_PAYLOAD_DIR)
	cp -r $(MAKEFILES_ROOT_DIR) $(DEB_BUILD_PAYLOAD_DIR)
	cp -r $(DOCS_ROOT_DIR) $(DEB_BUILD_PAYLOAD_DIR)
	cp $(MAKEFILE_PATH) $(DEB_BUILD_PAYLOAD_DIR)
	chmod +x $(DEB_BUILD_PAYLOAD_DIR)

install-source-on-payload:
	cd $(DEB_BUILD_PAYLOAD_DIR)/src && go mod tidy
	cd $(DEB_BUILD_PAYLOAD_DIR)/src && go mod vendor


build-package:
#	cd $(DEB_BUILD_PAYLOAD_DIR) && dpkg-buildpackage -S $(GPG_KEY_FLAG)
	echo "build başarılı" > $(DEB_BUILD_ROOT_DIR)/$(APP).txt
	@echo "Package has been created with version $(APP_TAG)"


package.deb.source.build: package.deb.source/prepare-output build-package package.deb.source/move-outputs


package.deb.source/prepare-output:
	@mkdir -p $(DEB_BUILD_OUTPUT_DIR)

package.deb.source/move-outputs:
	mv $(DEB_BUILD_ROOT_DIR)/$(APP).txt $(DEB_BUILD_OUTPUT_DIR)


package.deb.push-ppa:
	gpg --verify  $(DEB_BUILD_ROOT_DIR)/*.changes
	dput ppa:$(PPA) $(DEB_BUILD_ROOT_DIR)/*.changes
	@echo "Package has been pushed to $(PPA) with version $(APP_TAG)"




package.move-binary-to-package-source:
	echo "rm -rf $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT" >> $(RPM_BUILD_CONFIG_DIR)/$@
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT/$(DEB_BINARY_DIR)
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT/$(DEB_CONFIG_DIR)
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT/$(DEB_LOG_DIR)
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT/$(DEB_DATA_DATABASE_DIR)
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT/$(DEB_CACHE_DIR)
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT/$(DEB_LIB_DIR)
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT/$(DEB_SHARE_DIR)
	@mkdir -p $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT/$(DEB_DOCS_DIR)
	cp -r $(BIN_ROOT_DIR)/$(APP) $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT/$(DEB_BINARY_DIR)
	cp -r $(DOCS_USER_DOCS_DIR) $(RPM_BUILD_CONFIG_RPM_DIR)/BUILDROOT/$(DEB_DOCS_DIR)









$(DIST_ARTIFACTS_DIR)/%$(TAR_GZ_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(TAR_XZ_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(TAR_BZ2_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(ZIP_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))
	
$(DIST_ARTIFACTS_DIR)/%$(RAR_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(SEVEN_Z_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(ZST_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))

$(DIST_ARTIFACTS_DIR)/%$(LZ_EXT): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT)
	$(call compress_file,$(DEB_PACKAGE_EXT))


# $(foreach format,$(FORMATS),$(eval $(DIST_ARTIFACTS_DIR)/%$(format): $(DEB_BUILD_OUTPUT_DIR)/%$(DEB_PACKAGE_EXT) ; $(call compress_file,$(DEB_PACKAGE_EXT)) ))
package.deb.source.create-artifacts: $(addprefix $(DIST_ARTIFACTS_DIR)/, $(foreach format,$(FORMATS),$(notdir $(DEB_FILES:$(DEB_PACKAGE_EXT)=$(format)))))

