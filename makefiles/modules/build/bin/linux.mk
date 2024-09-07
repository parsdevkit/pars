include ./makefiles/modules/build/bin/common.mk

build.binary.linux:
	@$(MAKE) build.binary OS=$(OS_LINUX) ARCH=$(ARCH)
