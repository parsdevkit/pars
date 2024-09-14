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
	cp $(MAKEFILE_PATH) $(DEB_BUILD_PAYLOAD_DIR)/Makefile
	chmod +x $(DEB_BUILD_PAYLOAD_DIR)

install-source-on-payload:
	cd $(DEB_BUILD_PAYLOAD_DIR)/src && go mod tidy
	cd $(DEB_BUILD_PAYLOAD_DIR)/src && go mod vendor


package.deb.source.build: package.deb.source/prepare-output build-package package.deb.source/move-outputs

build-package:
#	cd $(DEB_BUILD_PAYLOAD_DIR) && dpkg-buildpackage -S $(GPG_KEY_FLAG)
	echo "build başarılı" > $(DEB_BUILD_ROOT_DIR)/$(APP).txt
	@echo "Package has been created with version $(APP_TAG)"



package.deb.source/prepare-output:
	@mkdir -p $(DEB_BUILD_OUTPUT_DIR)

package.deb.source/move-outputs:
	mv $(DEB_BUILD_ROOT_DIR)/$(APP).txt $(DEB_BUILD_OUTPUT_DIR)


package.deb.push-ppa:
	gpg --verify  $(DEB_BUILD_ROOT_DIR)/*.changes
	dput ppa:$(PPA) $(DEB_BUILD_ROOT_DIR)/*.changes
	@echo "Package has been pushed to $(PPA) with version $(APP_TAG)"




package.move-binary-to-package-source:
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_BINARY_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_CONFIG_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_LOG_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_DATA_DATABASE_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_CACHE_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_LIB_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_SHARE_DIR)
	@mkdir -p $(DEB_BUILD_CONFIG_DIR)/$(DEB_DOCS_DIR)
	cp -r $(BIN_ROOT_DIR)/$(APP) $(DEB_BUILD_CONFIG_DIR)/$(DEB_BINARY_DIR)
	cp -r $(DOCS_USER_DOCS_DIR) $(DEB_BUILD_CONFIG_DIR)/$(DEB_DOCS_DIR)





package.deb.source.copy-to-artifacts:
ifeq ($(APP_OS),$(OS_LINUX))
	tar -czvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).deb-src.tar.gz $(DEB_BUILD_OUTPUT_DIR)
	tar -cjvf $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).deb-src.tar.bz2 $(DEB_BUILD_OUTPUT_DIR)
	zip $(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH).deb-src.zip $(DEB_BUILD_OUTPUT_DIR)
endif


