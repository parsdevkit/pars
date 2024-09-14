include ./makefiles/modules/build/bin/common.mk

build.binary.freebsd:
	@$(MAKE) build.binary OS=$(OS_FREEBSD) ARCH=$(ARCH)

build.binary.freebsd.vendor:
	@$(MAKE) build.binary.vendor OS=$(OS_FREEBSD) ARCH=$(ARCH)

build.binary.netbsd:
	@$(MAKE) build.binary OS=$(OS_NETBSD) ARCH=$(ARCH)

build.binary.netbsd.vendor:
	@$(MAKE) build.binary.vendor OS=$(OS_NETBSD) ARCH=$(ARCH)

build.binary.openbsd:
	@$(MAKE) build.binary OS=$(OS_OPENBSD) ARCH=$(ARCH)

build.binary.openbsd.vendor:
	@$(MAKE) build.binary.vendor OS=$(OS_OPENBSD) ARCH=$(ARCH)
