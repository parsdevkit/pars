include ./makefiles/modules/build/bin/common.mk

build.binary.windows: 
	@$(MAKE) build.binary OS=$(OS_WINDOWS) ARCH=$(ARCH)

build.binary.windows.vendor:
	@$(MAKE) build.binary.vendor OS=$(OS_WINDOWS) ARCH=$(ARCH)
