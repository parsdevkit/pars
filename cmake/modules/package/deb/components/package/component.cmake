foreach(DEBARCH ${DEBARCH_LIST_LINUX})
    map_debarch_to_arch(${DEBARCH} APP_ARCH)
    set(DEB_ROOT_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/linux/pkg/${APP_ARCH})
    set(DEB_PAYLOAD_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/linux/pkg/${APP_ARCH}/${APP_NAME})
    set(DEB_OUTPUT_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/linux/pkg/${APP_ARCH}/output)

    add_custom_command(
        OUTPUT ${DEB_OUTPUT_DIR}
        COMMAND ${CMAKE_COMMAND} -E echo "Building source files."
        COMMAND chmod +w ${DEB_PAYLOAD_DIR} && cd ${DEB_PAYLOAD_DIR} && dpkg-buildpackage -S
        COMMAND mkdir ${DEB_OUTPUT_DIR}
        COMMAND $(DEB_ROOT_DIR)/$(APP_NAME)_* $(DEB_OUTPUT_DIR)
        COMMENT "Building .deb package"
    )

    add_custom_target(build.deb.package.${APP_ARCH}.package ALL DEPENDS check_env_for_deb_packing ${DEB_OUTPUT_DIR})

    add_custom_target(build.deb.package.${APP_ARCH})
    add_dependencies(build.deb.package.${APP_ARCH} 
        # build.deb.package.setup
        build.deb.package.${APP_ARCH}.configuration
        build.deb.package.${APP_ARCH}.payload
        build.deb.package.${APP_ARCH}.package
    )
endforeach()
