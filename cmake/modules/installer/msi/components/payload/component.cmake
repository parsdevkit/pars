get_host_os(HOST_OS)
set_os_ext(${HOST_OS} EXT)
set(PAYLOADS 
    .channel_number
    CMakeLists.txt
    .config
    cmake
    Makefile
    src
    docs
)

foreach(MSIARCH ${ALL_MSIARCH_LIST_WINDOWS})
    map_msiarch_to_arch_all(${MSIARCH} APP_ARCH)
    set(MSI_PAYLOAD_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/ins/${MSI_PACKAGE_NAME}/${APP_ARCH}/${APP_NAME})

    set(PAYLOAD_OUTPUTS "")

    foreach(PAYLOAD ${PAYLOADS})
        list(APPEND PAYLOAD_OUTPUTS ${MSI_PAYLOAD_DIR}/${PAYLOAD})
        command_for_shell("powershell" "Copy-Item -Recurse -Force '${SOURCE_ROOT_DIR}/${PAYLOAD}' '${MSI_PAYLOAD_DIR}'" SHELL_GO_BUILD_COMMAND)
        add_custom_command(
            OUTPUT ${MSI_PAYLOAD_DIR}/${PAYLOAD}
            COMMAND ${SHELL_GO_BUILD_COMMAND}
            VERBATIM
            COMMENT "Copying payloads to ${MSI_PAYLOAD_DIR}"
        )
    endforeach()

    add_custom_command(
        OUTPUT ${MSI_PAYLOAD_DIR}/src/vendor
        COMMAND cd ${MSI_PAYLOAD_DIR}/src && go mod tidy
        COMMAND cd ${MSI_PAYLOAD_DIR}/src && go mod vendor
        COMMENT "Preparing payloads to ${MSI_PAYLOAD_DIR}"
    )

    add_custom_command(
        OUTPUT ${MSI_PAYLOAD_DIR}/${APP_NAME}${EXT}
        COMMAND ${SHELL_GO_BUILD_COMMAND_CREATE_SOURCES_FOLDER}
        COMMAND make build.cmake.windows VERSION=${APP_TAG}
        COMMAND make build.binary OUTPUT=${MSI_PAYLOAD_DIR}/${APP_NAME}${EXT}
        VERBATIM
        WORKING_DIRECTORY ${MSI_PAYLOAD_DIR}
        COMMENT "Creating binary to ${MSI_PAYLOAD_DIR}"
    )
add_custom_target(build.msi.package.${APP_ARCH}.payload DEPENDS check_env_for_msi_packing ${PAYLOAD_OUTPUTS} ${MSI_PAYLOAD_DIR}/src/vendor ${MSI_PAYLOAD_DIR}/${APP_NAME}${EXT})
endforeach()