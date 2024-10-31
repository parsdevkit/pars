build.cmake.linux:
	@cmake -B build/current -S . -DVERSION=$(VERSION) -DRELEASE_DATE=$(RELEASE_DATE)

build.cmake.linux.%:
	@cmake -B build/$* -S . -DVERSION=$* -DRELEASE_DATE=$(RELEASE_DATE)

build.cmake.macos:
	@cmake -B build/current -S . -DVERSION=$(VERSION) -DRELEASE_DATE=$(RELEASE_DATE)

build.cmake.macos.%:
	@cmake -B build/$* -S . -DVERSION=$* -DRELEASE_DATE=$(RELEASE_DATE)

build.cmake.windows:
	@cmake -B build/current -S . -DVERSION=$(VERSION) -G "MinGW Makefiles" -DRELEASE_DATE=$(RELEASE_DATE)

build.cmake.windows.%:
	@cmake -B build/$* -S . -G "MinGW Makefiles" -DVERSION=$* -DRELEASE_DATE=$(RELEASE_DATE)

%:
	$(MAKE) -C build/$(if $(VERSION),$(VERSION),current) $@