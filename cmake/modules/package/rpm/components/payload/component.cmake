get_host_os(HOST_OS)
set(PAYLOADS 
    CMakeLists.txt
    .config
    cmake
    Makefile
    src
    docs
)

foreach(RPMARCH ${ALL_RPMARCH_LIST_LINUX})
    map_rpmarch_to_arch_all(${RPMARCH} APP_ARCH)
    set(RPM_PAYLOAD_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/pkg/${RPM_PACKAGE_NAME}/${APP_ARCH}/${APP_NAME})

    set(PAYLOAD_OUTPUTS "")
    foreach(PAYLOAD ${PAYLOADS})
        list(APPEND PAYLOAD_OUTPUTS ${RPM_PAYLOAD_DIR}/${PAYLOAD})
        add_custom_command(
            OUTPUT ${RPM_PAYLOAD_DIR}/${PAYLOAD}
            COMMAND cp -r ${SOURCE_ROOT_DIR}/${PAYLOAD} ${RPM_PAYLOAD_DIR}/
            COMMENT "Copying payloads to ${RPM_PAYLOAD_DIR}"
        )
    endforeach()

    add_custom_command(
        OUTPUT ${RPM_PAYLOAD_DIR}/src/vendor
        COMMAND cd ${RPM_PAYLOAD_DIR}/src && go mod tidy
        COMMAND cd ${RPM_PAYLOAD_DIR}/src && go mod vendor
        COMMENT "Preparing payloads to ${RPM_PAYLOAD_DIR}"
    )
add_custom_target(build.rpm.package.${APP_ARCH}.payload DEPENDS check_env_for_rpm_packing ${PAYLOAD_OUTPUTS} ${RPM_PAYLOAD_DIR}/src/vendor)
endforeach()