get_host_os(HOST_OS)
set(PAYLOADS 
    CMakeLists.txt
    .config
    cmake
    Makefile
    src
    docs
)

foreach(CHOCOARCH ${ALL_CHOCOARCH_LIST_LINUX})
    map_chocoarch_to_arch_all(${CHOCOARCH} APP_ARCH)
    set(CHOCO_PAYLOAD_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/pkg/${CHOCO_PACKAGE_NAME}/${APP_ARCH}/${APP_NAME})

    set(PAYLOAD_OUTPUTS "")
    foreach(PAYLOAD ${PAYLOADS})
        list(APPEND PAYLOAD_OUTPUTS ${CHOCO_PAYLOAD_DIR}/${PAYLOAD})
        add_custom_command(
            OUTPUT ${CHOCO_PAYLOAD_DIR}/${PAYLOAD}
            COMMAND cp -r ${SOURCE_ROOT_DIR}/${PAYLOAD} ${CHOCO_PAYLOAD_DIR}/
            COMMENT "Copying payloads to ${CHOCO_PAYLOAD_DIR}"
        )
    endforeach()

    add_custom_command(
        OUTPUT ${CHOCO_PAYLOAD_DIR}/src/vendor
        COMMAND cd ${CHOCO_PAYLOAD_DIR}/src && go mod tidy
        COMMAND cd ${CHOCO_PAYLOAD_DIR}/src && go mod vendor
        COMMENT "Preparing payloads to ${CHOCO_PAYLOAD_DIR}"
    )
    add_custom_target(build.choco.package.${APP_ARCH}.payload DEPENDS check_env_for_choco_packing ${PAYLOAD_OUTPUTS} ${CHOCO_PAYLOAD_DIR}/src/vendor)
endforeach()