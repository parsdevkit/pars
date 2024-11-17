get_host_os(HOST_OS)

foreach(MSIARCH ${ALL_MSIARCH_LIST_LINUX})
    map_msiarch_to_arch_all(${MSIARCH} APP_ARCH)
    set(MSI_ROOT_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/pkg/${MSI_PACKAGE_NAME}/${APP_ARCH})
    set(MSI_PAYLOAD_DIR ${MSI_ROOT_DIR}/${APP_NAME})
    set(MSI_OUTPUT_DIR ${MSI_ROOT_DIR}/output)

    add_custom_command(
        OUTPUT ${MSI_OUTPUT_DIR}
        COMMAND ${CMAKE_COMMAND} -E echo "Building source files."
        COMMAND cd ${MSI_PAYLOAD_DIR} && msicraft
        COMMAND mkdir -p ${MSI_OUTPUT_DIR}
        COMMAND mv ${MSI_ROOT_DIR}/${APP_NAME}/${APP_NAME}_*.msi ${MSI_OUTPUT_DIR}/
        COMMENT "Building .msi package"
    )

    add_custom_target(build.msi.package.${APP_ARCH}.package DEPENDS check_env_for_msi_packing ${MSI_OUTPUT_DIR})

    add_custom_target(build.msi.package.${APP_ARCH})
    add_dependencies(build.msi.package.${APP_ARCH} 
        # build.msi.package.setup
        build.msi.package.${APP_ARCH}.configuration
        build.msi.package.${APP_ARCH}.payload
        build.msi.package.${APP_ARCH}.package
    )
endforeach()