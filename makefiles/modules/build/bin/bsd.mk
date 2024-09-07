include ./makefiles/modules/build/bin/common.mk

build.binary.bsd:
	@$(MAKE) build.binary OS=$(OS_BSD) ARCH=$(ARCH)
