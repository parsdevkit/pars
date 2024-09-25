include ./makefiles/modules/release/common.mk

changelog.init:
	@mkdir -p $(DIST_RELEASE_ROOT_DIR)

changelog.entry.add: changelog.init
ifeq ($(strip $(message)),)
	@echo "No message provided; nothing added to changelog."
else
	@echo "* $(message)" >> $(CHANGELOG_PATH)
	@echo 'message "$(message)" added to changelog.'
endif

changelog.clear:
	echo "" > $(CHANGELOG_PATH)
