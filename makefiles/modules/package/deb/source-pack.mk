include ./makefiles/modules/package/deb/common.mk

package.deb.source.prepare.config: DEB_PACK_TYPE = source
package.deb.source.prepare.config:
	$(MAKE) package.deb.prepare.config DEB_PACK_TYPE=$(DEB_PACK_TYPE)

package.deb.source.prepare.payload: DEB_PACK_TYPE = source
package.deb.source.prepare.payload:
	cp -r $(SOURCE_ROOT_DIR) $(DEB_BUILD_PAYLOAD_DIR)
	cp -r $(MAKEFILES_ROOT_DIR) $(DEB_BUILD_PAYLOAD_DIR)
	cp -r $(DOCS_ROOT_DIR) $(DEB_BUILD_PAYLOAD_DIR)
	cp $(MAKEFILE_PATH) $(DEB_BUILD_PAYLOAD_DIR)
	chmod +x $(DEB_BUILD_PAYLOAD_DIR)
	cd $(DEB_BUILD_PAYLOAD_DIR)/src && go mod tidy
	cd $(DEB_BUILD_PAYLOAD_DIR)/src && go mod vendor



package.deb.source.build:
	@mkdir -p $(DEB_BUILD_OUTPUT_DIR)
	cd $(DEB_BUILD_PAYLOAD_DIR) && dpkg-buildpackage -S $(GPG_KEY_FLAG)
	@echo "Package has been created with version $(APP_TAG)"
	cp -r $(DEB_BUILD_ROOT_DIR)/$(APP)_* $(DEB_BUILD_OUTPUT_DIR)


package.deb.push-ppa:
	gpg --verify  $(DEB_BUILD_ROOT_DIR)/*.changes
	dput ppa:$(PPA) $(DEB_BUILD_ROOT_DIR)/*.changes
	@echo "Package has been pushed to $(PPA) with version $(APP_TAG)"










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

