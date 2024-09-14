include ./makefiles/modules/release/common.mk
include ./makefiles/variables.mk
include ./makefiles/init.mk

artifacts.checksums:
	@echo "Generating checksums..."
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@echo "MD5 Checksums" > $(DIST_ARTIFACTS_DIR)/checksums.txt
	@cd $(DIST_ARTIFACTS_DIR) && md5sum $(wildcard ./*) >> checksums.txt
	@echo "" >> $(DIST_ARTIFACTS_DIR)/checksums.txt
	@echo "SHA1 Checksums" >> $(DIST_ARTIFACTS_DIR)/checksums.txt
	@cd $(DIST_ARTIFACTS_DIR) && sha1sum $(wildcard ./*) >> checksums.txt
	@echo "" >> $(DIST_ARTIFACTS_DIR)/checksums.txt
	@echo "SHA256 Checksums" >> $(DIST_ARTIFACTS_DIR)/checksums.txt
	@cd $(DIST_ARTIFACTS_DIR) && sha256sum $(wildcard ./*) >> checksums.txt
	@echo "Checksums have been written to $(DIST_ARTIFACTS_DIR)/checksums.txt."
