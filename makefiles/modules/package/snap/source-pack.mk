include ./makefiles/modules/package/snap/common.mk


package.snap.source.prepare.config: SNAP_PACK_TYPE = source
package.snap.source.prepare.config:
	$(MAKE) package.snap.prepare.config SNAP_PACK_TYPE=$(SNAP_PACK_TYPE)


package.snap.source.prepare.payload: SNAP_PACK_TYPE = source
package.snap.source.prepare.payload: copy-source-to-payload
# package.snap.source.prepare.payload: install-source-on-payload
# package.snap.source.prepare.payload: copy-source-to-payload install-source-on-payload

copy-source-to-payload:
	cp -r $(SOURCE_ROOT_DIR) $(SNAP_BUILD_PAYLOAD_DIR)
	cp -r $(MAKEFILES_ROOT_DIR) $(SNAP_BUILD_PAYLOAD_DIR)
	cp -r $(DOCS_ROOT_DIR) $(SNAP_BUILD_PAYLOAD_DIR)
	cp $(MAKEFILE_PATH) $(SNAP_BUILD_PAYLOAD_DIR)
	chmod +x $(SNAP_BUILD_PAYLOAD_DIR)

install-source-on-payload:
	cd $(SNAP_BUILD_PAYLOAD_DIR)/src && go mod tidy
	cd $(SNAP_BUILD_PAYLOAD_DIR)/src && go mod vendor




package.snap.source/move-outputs:
	mv $(SNAP_BUILD_CONFIG_DIR)/$(APP)*.snap $(SNAP_BUILD_OUTPUT_DIR)

define compress
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@echo "Processing $< for $1 format..."
	@bash -c ' \
	FILENAME=$$(basename $<) ; \
	BASENAME=$${FILENAME%_*} ; \
	MATCH_ARCH=$${FILENAME##*_} ; \
	MATCH_ARCH_NO_EXT=$${MATCH_ARCH%$(SNAP_PACKAGE_EXT)} ; \
	OUTPUT_NAME=$(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$$MATCH_ARCH_NO_EXT$(SNAP_PACKAGE_EXT).$1 ; \
	if [ "$1" = "zip" ]; then \
		echo "Compressing $< to $$OUTPUT_NAME..." ; \
		zip $$OUTPUT_NAME $< ; \
	else \
		echo "Compressing $< to $$OUTPUT_NAME..." ; \
		$2 $$OUTPUT_NAME -C $(SNAP_BUILD_OUTPUT_DIR) $$(basename $<) ; \
	fi'
endef

package.snap.source.create-artifacts: $(addprefix $(DIST_ARTIFACTS_DIR)/, $(notdir $(SNAP_FILES:$(SNAP_PACKAGE_EXT)=$(TAR_GZ_EXT))) $(notdir $(SNAP_FILES:$(SNAP_PACKAGE_EXT)=$(TAR_BZ2_EXT))) $(notdir $(SNAP_FILES:$(SNAP_PACKAGE_EXT)=$(ZIP_EXT))))

$(DIST_ARTIFACTS_DIR)/%$(TAR_GZ_EXT): $(SNAP_BUILD_OUTPUT_DIR)/%$(SNAP_PACKAGE_EXT)
	$(call compress,tar.gz,tar -czf)

$(DIST_ARTIFACTS_DIR)/%$(TAR_BZ2_EXT): $(SNAP_BUILD_OUTPUT_DIR)/%$(SNAP_PACKAGE_EXT)
	$(call compress,tar.bz2,tar -cjvf)

$(DIST_ARTIFACTS_DIR)/%$(ZIP_EXT): $(SNAP_BUILD_OUTPUT_DIR)/%$(SNAP_PACKAGE_EXT)
	$(call compress,zip)





# package.snap.source.build: package.snap.source/move-outputs
# package.snap.source.build: build-package package.snap.source/move-outputs

