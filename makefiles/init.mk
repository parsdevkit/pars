include ./makefiles/variables.mk

ifeq ($(APP_OS),Windows_NT)
	HOST_OS = windows
	HOST_ARCH_RAW := $(Get-WmiObject Win32_OperatingSystem).OSArchitecture
	ifeq ($(HOST_ARCH_RAW),64-bit)
		HOST_ARCH = amd64
	else
		HOST_ARCH = amd
	endif
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		HOST_OS = darwin
	else ifeq ($(UNAME_S),Linux)
		HOST_OS = linux
	else ifeq ($(UNAME_S),FreeBSD)
		HOST_OS = freebsd
	else ifeq ($(UNAME_S),OpenBSD)
		HOST_OS = openbsd
	else ifeq ($(UNAME_S),NetBSD)
		HOST_OS = netbsd
	else ifeq ($(UNAME_S),DragonFly)
		HOST_OS = dragonflybsd
	else ifeq ($(UNAME_S),SunOS)
		HOST_OS = solaris
	else
		HOST_OS = unknown
	endif


	UNAME_M := $(shell uname -m)
	ifeq ($(UNAME_M),x86_64)
		HOST_ARCH = amd64
	else ifeq ($(UNAME_M),i386)
		HOST_ARCH = amd64
	else ifeq ($(UNAME_M),i386)
		HOST_ARCH = 386
	else ifeq ($(UNAME_M),i686)
		HOST_ARCH = 386
	# else ifeq ($(UNAME_M),armv7l)
	# 	HOST_ARCH = armv7
	else ifeq ($(UNAME_M),aarch64)
		HOST_ARCH = arm64
	else ifeq ($(UNAME_M),ppc64le)
		HOST_ARCH = ppc64le
	else ifeq ($(UNAME_M),ppc64)
		HOST_ARCH = ppc64
	# else ifeq ($(UNAME_M),s390x)
	# 	HOST_ARCH = s390x
	else
		HOST_ARCH = unknown
	endif
endif

ifeq ($(APP_OS),)
	APP_OS = $(HOST_OS)
else ifeq ($(APP_OS), Windows_NT)
	APP_OS = $(HOST_OS)
endif

ifeq ($(APP_ARCH),)
	APP_ARCH = $(HOST_ARCH)
endif


ifeq ($(APP_OS), windows)
	APP := $(APPLICATION_NAME).exe
endif


CHANNEL := test
GIT_TAG := $(shell git describe --tags --abbrev=0)
COMMITS_SINCE_TAG := $(shell git rev-list $(GIT_TAG)..HEAD --count)


CHANNEL_NUMBER_FILE := .channel_number


CHANNEL_NUMBER := $(shell cat $(CHANNEL_NUMBER_FILE) 2>/dev/null || echo 1)
ifeq ($(CHANNEL_NUMBER), )
	CHANNEL_NUMBER = 1
endif

APP_TAG := $(TAG)
ifeq ($(APP_TAG), )
	APP_TAG := $(GIT_TAG)-$(CHANNEL).$(CHANNEL_NUMBER)
endif

RAW_VERSION := $(shell echo $(APP_TAG) | sed 's/^v//')



ifeq ($(APP_OS),$(OS_LINUX))
	ifeq ($(APP_ARCH),$(ARCH_AMD64))
		BUILD_ARCH = $(LINUX_ARCH_AMD64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM64))
		BUILD_ARCH = $(LINUX_ARCH_ARM64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM))
		BUILD_ARCH = $(LINUX_ARCH_ARM_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_386))
		BUILD_ARCH = $(LINUX_ARCH_386_VALUE)
	endif
else ifeq ($(APP_OS),$(OS_WINDOWS))
	ifeq ($(APP_ARCH),$(ARCH_AMD64))
		BUILD_ARCH = $(WINDOWS_ARCH_AMD64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM64))
		BUILD_ARCH = $(WINDOWS_ARCH_ARM64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM))
		BUILD_ARCH = $(WINDOWS_ARCH_ARM_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_386))
		BUILD_ARCH = $(WINDOWS_ARCH_386_VALUE)
	endif
else ifeq ($(APP_OS),$(OS_MACOS))
	ifeq ($(APP_ARCH),$(ARCH_AMD64))
		BUILD_ARCH = $(MAC_ARCH_AMD64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM64))
		BUILD_ARCH = $(MAC_ARCH_ARM64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM))
		BUILD_ARCH = $(MAC_ARCH_ARM_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_386))
		BUILD_ARCH = $(MAC_ARCH_386_VALUE)
	endif
else ifeq ($(APP_OS),$(OS_FREEBSD))
	ifeq ($(APP_ARCH),$(ARCH_AMD64))
		BUILD_ARCH = $(BSD_ARCH_AMD64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM64))
		BUILD_ARCH = $(BSD_ARCH_ARM64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM))
		BUILD_ARCH = $(BSD_ARCH_ARM_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_386))
		BUILD_ARCH = $(BSD_ARCH_386_VALUE)
	endif
else ifeq ($(APP_OS),$(OS_NETBSD))
	ifeq ($(APP_ARCH),$(ARCH_AMD64))
		BUILD_ARCH = $(BSD_ARCH_AMD64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM64))
		BUILD_ARCH = $(BSD_ARCH_ARM64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM))
		BUILD_ARCH = $(BSD_ARCH_ARM_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_386))
		BUILD_ARCH = $(BSD_ARCH_386_VALUE)
	endif
else ifeq ($(APP_OS),$(OS_OPENBSD))
	ifeq ($(APP_ARCH),$(ARCH_AMD64))
		BUILD_ARCH = $(BSD_ARCH_AMD64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM64))
		BUILD_ARCH = $(BSD_ARCH_ARM64_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_ARM))
		BUILD_ARCH = $(BSD_ARCH_ARM_VALUE)
	else ifeq ($(APP_ARCH),$(ARCH_386))
		BUILD_ARCH = $(BSD_ARCH_386_VALUE)
	endif
endif




# increment_channel_number:
# 	@echo "Incrementing channel number..."
# 	@echo $$(($(CHANNEL_NUMBER) + 1)) > $(CHANNEL_NUMBER_FILE)

