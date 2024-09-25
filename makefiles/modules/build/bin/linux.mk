include ./makefiles/modules/build/bin/common.mk

build.binary.linux:
	@$(MAKE) build.binary OS=$(OS_LINUX) ARCH=$(ARCH)

build.binary.linux.vendor:
	@$(MAKE) build.binary.vendor OS=$(OS_LINUX) ARCH=$(ARCH)
