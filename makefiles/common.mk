include ./makefiles/variables.mk
include ./makefiles/init.mk


help:
	@echo "Available commands:"
	@echo "  build.binary.windows:		Build"


update_channel_number.$(OS_LINUX):
	@CURRENT_NUMBER=$(CHANNEL_NUMBER); \
	NEW_NUMBER=$$((CURRENT_NUMBER + 1)); \
	echo $$NEW_NUMBER > $(CHANNEL_NUMBER_FILE);
	@echo "Channel number updated to $$(cat $(CHANNEL_NUMBER_FILE))"

update_channel_number.$(OS_WINDOWS):
	@powershell -ExecutionPolicy Bypass -Command \
	"$$current_number = $(CHANNEL_NUMBER); \
	 $$new_number = $$($$current_number + 1); \
	 Set-Content -Path '$(CHANNEL_NUMBER_FILE)' -Value $$new_number; \
	 Write-Host 'Channel number updated to ' $$new_number;"


update_channel_number: update_channel_number.$(HOST_OS)

print:
#	@echo "Detected OS: $(HOST_OS)"
#	@echo "Detected Architecture: $(HOST_ARCH)"
#	@echo "Application OS: $(APP_OS), ARCH: $(APP_ARCH)"
#	@echo "Application: $(APP)", TAG: $(APP_TAG)
	
	@echo "OS: $(HOST_OS)"
	@echo "RAW_VERSION: $(RAW_VERSION)"
	@echo "APP_TAG: $(APP_TAG)"
	@echo "APP_TAG_VERSION: $(APP_TAG_VERSION)"
	@echo "APP_TAG_RELEASE: $(APP_TAG_RELEASE)"
	@echo "RELEASE_DATE: $(RELEASE_DATE)"
	@echo "RELEASE_DATE_STD: $(RELEASE_DATE_STD)"
	@echo "CHANNEL_NUMBER: $(CHANNEL_NUMBER)"


# increment_channel_number:
# 	@echo "Incrementing channel number..."
# 	@echo $$(($(CHANNEL_NUMBER) + 1)) > $(CHANNEL_NUMBER_FILE)



define determine_arch_flag_value
  $(if $(strip $(ARCH)),$(APP_ARCH),)
endef

define determine_arch_folder
  $(if $(strip $(ARCH)),$(APP_ARCH),\
    $(if $(filter binary,$(1)),$(APP_ARCH),all))
endef
define determine_pack_dir
  $(if $(filter binary,$(1)),\
    binary/$(ARCH_FOLDER),\
    $(if $(filter source,$(1)),\
      source/$(ARCH_FOLDER),\
      $(error Unsupported RPM_PACK_TYPE: $(1))))
endef



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


