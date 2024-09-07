include makefiles/common.mk


ifeq ($(MAKECMDGOALS), package.deb.build.binary)
include ./makefiles/modules/package/deb/binary-pack.mk
endif


ifeq ($(MAKECMDGOALS), package.deb.build.source)
include ./makefiles/modules/package/deb/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.deb.push-ppa)
include ./makefiles/modules/package/deb/source-pack.mk
endif


ifeq ($(MAKECMDGOALS), package.move-source-code-to-package-source)
include ./makefiles/modules/package/deb/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.move-binary-to-package-source)
include ./makefiles/modules/package/deb/source-pack.mk
endif


### BUILD
ifeq ($(MAKECMDGOALS), build.binary)
include ./makefiles/modules/build/bin/common.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.vendor)
include ./makefiles/modules/build/bin/common.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.linux)
include ./makefiles/modules/build/bin/linux.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.linux.vendor)
include ./makefiles/modules/build/bin/linux.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.windows)
include ./makefiles/modules/build/bin/windows.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.windows.vendor)
include ./makefiles/modules/build/bin/windows.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.darwin)
include ./makefiles/modules/build/bin/darwin.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.darwin.vendor)
include ./makefiles/modules/build/bin/darwin.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.bsd)
include ./makefiles/modules/build/bin/bsd.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.bsd.vendor)
include ./makefiles/modules/build/bin/bsd.mk
endif

ifeq ($(MAKECMDGOALS), build.image.lxc)
include ./makefiles/modules/build/image/lxc.mk
endif

ifeq ($(MAKECMDGOALS), build.image.docker)
include ./makefiles/modules/build/image/docker.mk
endif

ifeq ($(MAKECMDGOALS), build.image.containerd)
include ./makefiles/modules/build/image/containerd.mk
endif

### RELEASE

ifeq ($(MAKECMDGOALS), changelog.entry.add)
include ./makefiles/modules/release/changelog.mk
endif

ifeq ($(MAKECMDGOALS), changelog.clear)
include ./makefiles/modules/release/changelog.mk
endif

