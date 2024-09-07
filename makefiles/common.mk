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

