build.cmake.linux:
	@cmake -B build/current -S . -DVERSION=$(VERSION)

build.cmake.linux.%:
	@cmake -B build/$* -S . -DVERSION=$*

build.cmake.macos:
	@cmake -B build/current -S . -DVERSION=$(VERSION)

build.cmake.macos.%:
	@cmake -B build/$* -S . -DVERSION=$*

build.cmake.windows:
	@cmake -B build/current -S . -DVERSION=$(VERSION) -G "MinGW Makefiles"

build.cmake.windows.%:
	@cmake -B build/$* -S . -G "MinGW Makefiles" -DVERSION=$*

%:
	$(MAKE) -C build/$(if $(VERSION),$(VERSION),current) $@