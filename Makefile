CONFIG_FILE := build/$(if $(VERSION),$(VERSION),current)/config.mk
-include $(CONFIG_FILE)

build.cmake.linux:
	@cmake -B build/current -S . -DVERSION=$(VERSION) -DRELEASE_DATE=$(RELEASE_DATE)
	@echo "CONFIG_VERSION=$(VERSION)" > build/current/config.mk
	@echo "CONFIG_RELEASE_DATE=$(RELEASE_DATE)" >> build/current/config.mk

build.cmake.linux.%:
	@cmake -B build/$* -S . -DVERSION=$* -DRELEASE_DATE=$(RELEASE_DATE)
	@echo "CONFIG_VERSION=$*" > build/$*/config.mk
	@echo "CONFIG_RELEASE_DATE=$(RELEASE_DATE)" >> build/$*/config.mk

build.cmake.macos:
	@cmake -B build/current -S . -DVERSION=$(VERSION) -DRELEASE_DATE=$(RELEASE_DATE)
	@echo "CONFIG_VERSION=$(VERSION)" > build/current/config.mk
	@echo "CONFIG_RELEASE_DATE=$(RELEASE_DATE)" >> build/current/config.mk

build.cmake.macos.%:
	@cmake -B build/$* -S . -DVERSION=$* -DRELEASE_DATE=$(RELEASE_DATE)
	@echo "CONFIG_VERSION=$*" > build/$*/config.mk
	@echo "CONFIG_RELEASE_DATE=$(RELEASE_DATE)" >> build/$*/config.mk

build.cmake.windows:
	@cmake -B build/current -S . -DVERSION=$(VERSION) -G "MinGW Makefiles" -DRELEASE_DATE=$(RELEASE_DATE)
	@echo "CONFIG_VERSION=$(VERSION)" > build/current/config.mk
	@echo "CONFIG_RELEASE_DATE=$(RELEASE_DATE)" >> build/current/config.mk

build.cmake.windows.%:
	@cmake -B build/$* -S . -G "MinGW Makefiles" -DVERSION=$* -DRELEASE_DATE=$(RELEASE_DATE)
	@echo "CONFIG_VERSION=$*" > build/$*/config.mk
	@echo "CONFIG_RELEASE_DATE=$(RELEASE_DATE)" >> build/$*/config.mk

%:
	$(MAKE) $(MAKEOVERRIDES) VERSION=$(CONFIG_VERSION) RELEASE_DATE=$(CONFIG_RELEASE_DATE)
	$(MAKE) -C build/$(if $(VERSION),$(VERSION),current) $@