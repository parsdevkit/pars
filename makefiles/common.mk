include ./makefiles/variables.mk
include ./makefiles/init.mk


help:
	@echo "Available commands:"
	@echo "  build.binary.windows:		Build"


update_channel_number:
	@CURRENT_NUMBER=$(CHANNEL_NUMBER); \
	NEW_NUMBER=$$((CURRENT_NUMBER + 1)); \
	echo $$NEW_NUMBER > $(CHANNEL_NUMBER_FILE);
	@echo "Channel number updated to $$(cat $(CHANNEL_NUMBER_FILE))"

print:
	@echo "Detected OS: $(HOST_OS)"
	@echo "Detected Architecture: $(HOST_ARCH)"
	@echo "Application OS: $(APP_OS), ARCH: $(APP_ARCH)"
	@echo "Application: $(APP)", TAG: $(APP_TAG)


# increment_channel_number:
# 	@echo "Incrementing channel number..."
# 	@echo $$(($(CHANNEL_NUMBER) + 1)) > $(CHANNEL_NUMBER_FILE)




define compress_folder
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@bash -c ' \
	FILENAME=$$(basename $<) ; \
	DIRNAME=$$(dirname $<) ; \
	BASENAME=$${FILENAME%$2} ; \
	MATCH_ARCH=$${BASENAME##*_} ; \
	OUTPUT_NAME=$(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$(BUILD_ARCH)$2$1 ; \
	SHORT_FILENAME=$$(basename $$OUTPUT_NAME) ; \
	case "$1" in \
		$(ZIP_EXT)) \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using zip..." ; \
			zip $$OUTPUT_NAME -j $$TEMP_DIR/$$FILENAME ; \
			;; \
		$(TAR_GZ_EXT)) \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using tar.gz..." ; \
			tar -czf $$OUTPUT_NAME -C $$DIRNAME . ; \
			;; \
		$(TAR_BZ2_EXT)) \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using tar.bz2..." ; \
			tar -cjf $$OUTPUT_NAME -C $$DIRNAME . ; \
			;; \
		$(TAR_XZ_EXT)) \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using tar.xz..." ; \
			tar -cJf $$OUTPUT_NAME -C $$DIRNAME . ; \
			;; \
		$(SEVEN_Z_EXT)) \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using 7z..." ; \
			TEMP_DIR=$$(mktemp -d) ; \
			cp $< $$TEMP_DIR/$$FILENAME ; \
			7z a $$OUTPUT_NAME $$TEMP_DIR/$$FILENAME ; \
			rm -r $$TEMP_DIR ; \
			;; \
		$(RAR_EXT)) \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using rar..." ; \
			TEMP_DIR=$$(mktemp -d) ; \
			cp $< $$TEMP_DIR/$$FILENAME ; \
			rar a $$OUTPUT_NAME $$TEMP_DIR/$$FILENAME ; \
			rm -r $$TEMP_DIR ; \
			;; \
		$(LZ_EXT)) \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using lzma..." ; \
			tar --lzma -cf $$OUTPUT_NAME -C $$DIRNAME . ; \
			;; \
		$(ZST_EXT)) \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using zstd..." ; \
			tar -cf - -C $$DIRNAME . | zstd -z -o $$OUTPUT_NAME ; \
			;; \
		*) \
			echo "Unsupported format: $1" >&2 ; \
			exit 1 ; \
			;; \
	esac'
endef



# gzip eklenecek
define compress_file
	@mkdir -p $(DIST_ARTIFACTS_DIR)
	@bash -c ' \
	SOURCE_EXT=$$(echo $(suffix $<)) ; \
	TARGET_FILENAME=$$(basename $@) ; \
	TARGET_EXT=$${TARGET_FILENAME#*} ; \
	FILENAME=$$(basename $<) ; \
	DIRNAME=$$(dirname $<) ; \
	BASENAME=$${FILENAME%$1} ; \
	MATCH_ARCH=$${BASENAME##*_} ; \
	ARTIFACT_NAME=$(DIST_ARTIFACTS_DIR)/$(APPLICATION_NAME)-$(APP_OS)-$(APP_TAG)-$$MATCH_ARCH$1 ; \
	case "$@" in \
		*$(ZIP_EXT)) \
			FULL_FILENAME=$$ARTIFACT_NAME$(ZIP_EXT) ; \
			SHORT_FILENAME=$$(basename $$FULL_FILENAME) ; \
			if [ -f "$$FULL_FILENAME" ]; then \
				echo "Removing existing $$FULL_FILENAME..."; \
				rm -f "$$FULL_FILENAME"; \
			fi; \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using zip..." ; \
			zip -j $$FULL_FILENAME $< ; \
			;; \
		*$(TAR_GZ_EXT)) \
			FULL_FILENAME=$$ARTIFACT_NAME$(TAR_GZ_EXT) ; \
			SHORT_FILENAME=$$(basename $$FULL_FILENAME) ; \
			if [ -f "$$FULL_FILENAME" ]; then \
				echo "Removing existing $$FULL_FILENAME..."; \
				rm -f "$$FULL_FILENAME"; \
			fi; \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using tar.gz..." ; \
			tar -czf $$FULL_FILENAME -C $$DIRNAME $$FILENAME ; \
			;; \
		*$(TAR_BZ2_EXT)) \
			FULL_FILENAME=$$ARTIFACT_NAME$(TAR_BZ2_EXT) ; \
			SHORT_FILENAME=$$(basename $$FULL_FILENAME) ; \
			if [ -f "$$FULL_FILENAME" ]; then \
				echo "Removing existing $$FULL_FILENAME..."; \
				rm -f "$$FULL_FILENAME"; \
			fi; \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using tar.bz2..." ; \
			tar -cjf $$FULL_FILENAME -C $$DIRNAME $$FILENAME ; \
			;; \
		*$(TAR_XZ_EXT)) \
			FULL_FILENAME=$$ARTIFACT_NAME$(TAR_XZ_EXT) ; \
			SHORT_FILENAME=$$(basename $$FULL_FILENAME) ; \
			if [ -f "$$FULL_FILENAME" ]; then \
				echo "Removing existing $$FULL_FILENAME..."; \
				rm -f "$$FULL_FILENAME"; \
			fi; \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using tar.xz..." ; \
			tar -cJf $$FULL_FILENAME -C $$DIRNAME $$FILENAME ; \
			;; \
		*$(SEVEN_Z_EXT)) \
			FULL_FILENAME=$$ARTIFACT_NAME$(SEVEN_Z_EXT) ; \
			SHORT_FILENAME=$$(basename $$FULL_FILENAME) ; \
			if [ -f "$$FULL_FILENAME" ]; then \
				echo "Removing existing $$FULL_FILENAME..."; \
				rm -f "$$FULL_FILENAME"; \
			fi; \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using 7z..." ; \
			curr_dir=$$(pwd) ; \
			cd $$DIRNAME ; \
			7z a "$$curr_dir/$$FULL_FILENAME" $$FILENAME ; \
			cd $$curr_dir ; \
			;; \
		*$(RAR_EXT)) \
			FULL_FILENAME=$$ARTIFACT_NAME$(RAR_EXT) ; \
			SHORT_FILENAME=$$(basename $$FULL_FILENAME) ; \
			if [ -f "$$FULL_FILENAME" ]; then \
				echo "Removing existing $$FULL_FILENAME..."; \
				rm -f "$$FULL_FILENAME"; \
			fi; \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using rar..." ; \
			rar a -ep1 $$FULL_FILENAME $< ; \
			;; \
		*$(LZ_EXT)) \
			FULL_FILENAME=$$ARTIFACT_NAME$(LZ_EXT) ; \
			SHORT_FILENAME=$$(basename $$FULL_FILENAME) ; \
			if [ -f "$$FULL_FILENAME" ]; then \
				echo "Removing existing $$FULL_FILENAME..."; \
				rm -f "$$FULL_FILENAME"; \
			fi; \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using lzma..." ; \
			tar --lzma -cf $$FULL_FILENAME -C $$DIRNAME $$FILENAME ; \
			;; \
		*$(ZST_EXT)) \
			FULL_FILENAME=$$ARTIFACT_NAME$(ZST_EXT) ; \
			SHORT_FILENAME=$$(basename $$FULL_FILENAME) ; \
			if [ -f "$$FULL_FILENAME" ]; then \
				echo "Removing existing $$FULL_FILENAME..."; \
				rm -f "$$FULL_FILENAME"; \
			fi; \
			echo "Compressing $$FILENAME to $$SHORT_FILENAME using zstd..." ; \
			tar -cf - $< | zstd -z -o $$FULL_FILENAME ; \
			;; \
		*) \
			echo "Unsupported format: $@" >&2 ; \
			exit 1 ; \
			;; \
	esac'
endef