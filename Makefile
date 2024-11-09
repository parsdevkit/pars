CONFIG_FILE := build/$(if $(VERSION),$(VERSION),current)/config.mk
ifneq ("$(wildcard $(CONFIG_FILE))","")
    -include $(CONFIG_FILE)
endif

define build_cmake
	@cmake -B $(1) -S . -DVERSION=$(2) -DRELEASE_DATE=$(RELEASE_DATE) $(3)
	@echo "CONFIG_VERSION=$(2)" > $(1)/config.mk
	@echo "CONFIG_RELEASE_DATE=$(RELEASE_DATE)" >> $(1)/config.mk
endef

build.cmake.linux:
	$(call build_cmake,build/current,$(VERSION),)

build.cmake.linux.%:
	$(call build_cmake,build/$*,$*,)

build.cmake.macos:
	$(call build_cmake,build/current,$(VERSION),)

build.cmake.macos.%:
	$(call build_cmake,build/$*,$*,)

build.cmake.windows:
	$(call build_cmake,build/current,$(VERSION),-G "MinGW Makefiles")

build.cmake.windows.%:
	$(call build_cmake,build/$*,$*,-G "MinGW Makefiles")


ifneq ($(OS),Windows_NT)
	UNAME_S := $(shell uname -s)
endif

build.cmake:
ifeq ($(OS),Windows_NT)
	$(MAKE) build.cmake.windows
else ifeq ($(UNAME_S),Linux)
	$(MAKE) build.cmake.linux
else ifeq ($(UNAME_S),Darwin)
	$(MAKE) build.cmake.macos
else
	$(error "Unsupported OS")
endif

build.cmake.%:
ifeq ($(OS),Windows_NT)
	$(MAKE) build.cmake.windows.$*
else ifeq ($(UNAME_S),Linux)
	$(MAKE) build.cmake.linux.$*
else ifeq ($(UNAME_S),Darwin)
	$(MAKE) build.cmake.macos.$*
else
	$(error "Unsupported OS")
endif

%:
	$(MAKE) $(MAKEOVERRIDES) VERSION=$(CONFIG_VERSION) RELEASE_DATE=$(CONFIG_RELEASE_DATE)
	$(MAKE) -C build/$(if $(VERSION),$(VERSION),current) $@
