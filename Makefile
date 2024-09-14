include makefiles/common.mk



ifeq ($(MAKECMDGOALS), package.deb.prepare.config)
include ./makefiles/modules/package/deb/common.mk
endif

ifeq ($(MAKECMDGOALS), package.deb.binary.prepare)
include ./makefiles/modules/package/deb/binary-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.deb.binary.build)
include ./makefiles/modules/package/deb/binary-pack.mk
endif


ifeq ($(MAKECMDGOALS), package.deb.source.prepare.config)
include ./makefiles/modules/package/deb/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.deb.source.prepare.payload)
include ./makefiles/modules/package/deb/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.deb.source.prepare.output)
include ./makefiles/modules/package/deb/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.deb.source.build)
include ./makefiles/modules/package/deb/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.deb.source.copy-to-artifacts)
include ./makefiles/modules/package/deb/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.deb.push-ppa)
include ./makefiles/modules/package/deb/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.move-binary-to-package-source)
include ./makefiles/modules/package/deb/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.snap.build.binary)
include ./makefiles/modules/package/snap/binary-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.snap.move-binary-to-package-source)
include ./makefiles/modules/package/snap/binary-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.snap.build.source)
include ./makefiles/modules/package/snap/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.snap.move-source-to-package-source)
include ./makefiles/modules/package/snap/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.snap.move-source-code-to-package-source)
include ./makefiles/modules/package/snap/source-pack.mk
endif

ifeq ($(MAKECMDGOALS), package.snap.move-binary-to-package-source2)
include ./makefiles/modules/package/snap/source-pack.mk
endif



### BUILD
ifeq ($(MAKECMDGOALS), build.binary.all)
include ./makefiles/modules/build/bin/common.mk
endif

ifeq ($(MAKECMDGOALS), build.binary)
include ./makefiles/modules/build/bin/common.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.vendor)
include ./makefiles/modules/build/bin/common.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.copy-to-artifacts)
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


ifeq ($(MAKECMDGOALS), artifacts.checksums)
include ./makefiles/modules/release/checksums.mk
endif


lint:
	@golangci-lint run ./src