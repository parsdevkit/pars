set(DEB_ARCH_X86 "i386")
set(DEB_ARCH_X86_64 "amd64")
set(DEB_ARCH_ARM "armhf")
set(DEB_ARCH_ARM64 "arm64")


set(DEB_SERIES noble)
set(DEB_PACKAGE_EXT .deb)
set(DEB_PACK_TYPE "source")


set(DEBARCH_LIST_LINUX "${DEB_ARCH_X86};${DEB_ARCH_X86_64};${DEB_ARCH_ARM};${DEB_ARCH_ARM64}")



execute_process(
    COMMAND bash -c "date -d '${RELEASE_DATE}' '+%a, %d %b %Y 00:00:00 +0000'"
    OUTPUT_VARIABLE RELEASE_DATE_DEB
    OUTPUT_STRIP_TRAILING_WHITESPACE
)


set(PACKAGE_ROOT_DIR "${CMAKE_BINARY_DIR}/linux/pkg/deb/${APP_ARCH}/${APP_NAME}")
set(DEB_ROOT_DIR "${CMAKE_BINARY_DIR}")
set(DEB_BUILD_ROOT_DIR "${DEB_ROOT_DIR}")
set(DEB_BUILD_CONFIG_DIR "${DEB_ROOT_DIR}/debian")
set(DEB_BUILD_PAYLOAD_DIR "${DEB_ROOT_DIR}/debian")
set(DEB_BUILD_OUTPUT_DIR "${DEB_ROOT_DIR}/debian")
set(DEB_BUILD_TEMP_DIR "${DEB_ROOT_DIR}/debian")


