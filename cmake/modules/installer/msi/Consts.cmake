get_host_os(HOST_OS)
set(MSI_ARCH_X86 "i386")
set(MSI_ARCH_X86_64 "x86_64")
set(MSI_ARCH_ARM "armhfp")
set(MSI_ARCH_ARM64 "aarch64")
set(MSI_ARCH_ALL "any")


set(MSI_PACKAGE_EXT .msi)
set(MSI_PACKAGE_NAME msi)
set(MSI_PACK_TYPE "source")
set(MSI_BASE "core22")

set(MSIARCH_LIST_WINDOWS "${MSI_ARCH_X86};${MSI_ARCH_X86_64};${MSI_ARCH_ARM};${MSI_ARCH_ARM64}")
set(ALL_MSIARCH_LIST_WINDOWS ${MSIARCH_LIST_WINDOWS})
list(APPEND ALL_MSIARCH_LIST_WINDOWS ${MSI_ARCH_ALL})


message(STATUS "RELEASE_DATE: ${RELEASE_DATE}")

execute_process(
    COMMAND bash -c "date -d '${RELEASE_DATE}' '+%a, %d %b %Y 00:00:00 +0000'"
    OUTPUT_VARIABLE RELEASE_DATE_MSI
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

message(STATUS "RELEASE_DATE_MSI: ${RELEASE_DATE_MSI}")

set(PACKAGE_ROOT_DIR "${CMAKE_BINARY_DIR}/${HOST_OS}/ins/${MSI_PACKAGE_NAME}/${APP_ARCH}/${APP_NAME}")
set(MSI_ROOT_DIR "${CMAKE_BINARY_DIR}")
set(MSI_BUILD_ROOT_DIR "${MSI_ROOT_DIR}")
set(MSI_BUILD_CONFIG_DIR "${MSI_ROOT_DIR}/${APP_NAME}")
set(MSI_BUILD_PAYLOAD_DIR "${MSI_ROOT_DIR}/SOURCES")
set(MSI_BUILD_OUTPUT_DIR "${MSI_ROOT_DIR}/output")
set(MSI_BUILD_TEMP_DIR "${MSI_ROOT_DIR}/temp")


