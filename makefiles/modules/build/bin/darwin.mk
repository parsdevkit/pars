include ./makefiles/modules/build/bin/common.mk

build.binary.darwin:
	@$(MAKE) build.binary OS=$(OS_MACOS) ARCH=$(ARCH)