

# Detect the platform if OS is not provided as an argument
ifeq ($(OS),Windows_NT)
	# Windows-specific settings		
	ifeq ($(OS),)
		OS = windows
	endif
	ifeq ($(ARCH),)
		UNAME_P := $(PROCESSOR_ARCHITECTURE)
		ifeq ($(UNAME_P),AMD64)
			ARCH = amd64
		endif
		ifeq ($(UNAME_P),x86)
			ARCH = 386
		endif
		ifeq ($(UNAME_P),ARM64)
			ARCH = arm64
		endif
		ifeq ($(UNAME_P),ARM)
			ARCH = arm
		endif
	endif
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		# macOS-specific settings
		ifeq ($(OS),)
			OS = darwin
		endif
		ifeq ($(ARCH),)
			UNAME_P := $(shell uname -m)
			ifeq ($(UNAME_P),x86_64)
				ARCH = amd64
			endif
			ifeq ($(UNAME_P),i386)
				ARCH = 386
			endif
			ifeq ($(UNAME_P),arm64)
				ARCH = arm64
			endif
			ifeq ($(UNAME_P),arm)
				ARCH = arm
			endif
		endif
	else
		# Linux-specific settings
		ifeq ($(OS),)
			OS = linux
		endif
		ifeq ($(ARCH),)
			UNAME_P := $(shell uname -m)
			ifeq ($(UNAME_P),x86_64)
				ARCH = amd64
			endif
			ifeq ($(UNAME_P),i386)
				ARCH = 386
			endif
			ifeq ($(UNAME_P),arm64)
				ARCH = arm64
			endif
			ifeq ($(UNAME_P),arm)
				ARCH = arm
			endif
		endif
	endif
endif

ifeq ($(OS), windows)
	TARGET := $(APP).exe
endif
ifeq ($(TAG), )
	TAG := v0.0.0
endif