
foreach(DEBARCH ${DEBARCH_LIST_LINUX})
    map_debarch_to_arch(${DEBARCH} APP_ARCH)
    set(DEB_PAYLOAD_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/linux/pkg/${APP_ARCH}/${APP_NAME})

    add_custom_command(
        OUTPUT ${DEB_PAYLOAD_DIR}/src
        COMMAND ${CMAKE_COMMAND} -E echo "Copying source files to ${DEB_PAYLOAD_DIR}"
        COMMAND cp -r ${SOURCE_ROOT_DIR}/Makefile ${DEB_PAYLOAD_DIR}/Makefile
        COMMAND cp -r ${SOURCE_ROOT_DIR}/build ${DEB_PAYLOAD_DIR}/build
        COMMAND cp -r ${SOURCE_ROOT_DIR}/src ${DEB_PAYLOAD_DIR}/src
        COMMAND cp -r ${SOURCE_ROOT_DIR}/docs ${DEB_PAYLOAD_DIR}/docs
        COMMAND cd ${DEB_PAYLOAD_DIR}/src && go mod tidy
        COMMAND cd ${DEB_PAYLOAD_DIR}/src && go mod vendor
        COMMENT "Copying payloads to ${DEB_PAYLOAD_DIR}"
    )

    add_custom_target(build.deb.package.${APP_ARCH}.payload ALL DEPENDS check_env_for_deb_packing ${DEB_PAYLOAD_DIR}/src)
endforeach()
