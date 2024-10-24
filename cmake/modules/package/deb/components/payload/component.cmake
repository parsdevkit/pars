set(PAYLOADS 
    .channel_number
    CMakeLists.txt
    cmake
    Makefile
    src
    docs
)

foreach(DEBARCH ${DEBARCH_LIST_LINUX})
    map_debarch_to_arch(${DEBARCH} APP_ARCH)
    set(DEB_PAYLOAD_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/linux/pkg/${APP_ARCH}/${APP_NAME})

    set(PAYLOAD_OUTPUTS "")
    foreach(PAYLOAD ${PAYLOADS})
        list(APPEND PAYLOAD_OUTPUTS ${DEB_PAYLOAD_DIR}/${PAYLOAD})
        add_custom_command(
            OUTPUT ${DEB_PAYLOAD_DIR}/${PAYLOAD}
            COMMAND cp -r ${SOURCE_ROOT_DIR}/${PAYLOAD} ${DEB_PAYLOAD_DIR}/
            COMMENT "Copying payloads to ${DEB_PAYLOAD_DIR}"
        )
    endforeach()

    add_custom_command(
        OUTPUT ${DEB_PAYLOAD_DIR}/src/vendor
        COMMAND cd ${DEB_PAYLOAD_DIR}/src && go mod tidy
        COMMAND cd ${DEB_PAYLOAD_DIR}/src && go mod vendor
        COMMENT "Preparing payloads to ${DEB_PAYLOAD_DIR}"
    )
add_custom_target(build.deb.package.${APP_ARCH}.payload DEPENDS check_env_for_deb_packing ${PAYLOAD_OUTPUTS} ${DEB_PAYLOAD_DIR}/src/vendor)
endforeach()

set(DEBARCH any)
set(DEB_PAYLOAD_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/linux/pkg/all/${APP_NAME})


set(PAYLOAD_OUTPUTS "")
foreach(PAYLOAD ${PAYLOADS})
    list(APPEND PAYLOAD_OUTPUTS ${DEB_PAYLOAD_DIR}/${PAYLOAD})
    add_custom_command(
        OUTPUT ${DEB_PAYLOAD_DIR}/${PAYLOAD}
        COMMAND cp -r ${SOURCE_ROOT_DIR}/${PAYLOAD} ${DEB_PAYLOAD_DIR}/
        COMMENT "Copying payloads to ${DEB_PAYLOAD_DIR}"
    )
endforeach()

add_custom_command(
    OUTPUT ${DEB_PAYLOAD_DIR}/src/vendor
    COMMAND cd ${DEB_PAYLOAD_DIR}/src && go mod tidy
    COMMAND cd ${DEB_PAYLOAD_DIR}/src && go mod vendor
    COMMENT "Preparing payloads to ${DEB_PAYLOAD_DIR}"
)
add_custom_target(build.deb.package.all.payload DEPENDS check_env_for_deb_packing ${PAYLOAD_OUTPUTS} ${DEB_PAYLOAD_DIR}/src/vendor)