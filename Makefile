include makefiles/common.mk
include makefiles/variables.mk


ifeq ($(MAKECMDGOALS), deb.binary.pack)
include ./makefiles/modules/package/deb/binary-pack.mk
endif

ifeq ($(MAKECMDGOALS), build.binary)
include ./makefiles/modules/build/bin/common.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.linux)
include ./makefiles/modules/build/bin/linux.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.windows)
include ./makefiles/modules/build/bin/windows.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.darwin)
include ./makefiles/modules/build/bin/darwin.mk
endif

ifeq ($(MAKECMDGOALS), build.binary.bsd)
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
