set(PACKAGE_ROOT_DIR "${CMAKE_BINARY_DIR}/linux/pkg/deb/${APP_ARCH}/${APP_NAME}/deb")
set(DEB_ROOT_DIR "${CMAKE_BINARY_DIR}/debian")
set(DEB_BUILD_CONFIG_DIR "${CMAKE_BINARY_DIR}/debian")







if(IS_LINUX)
    if(IS_DEBIAN)
        add_custom_command(
            OUTPUT check_env_for_deb_packing
            COMMAND ${CMAKE_COMMAND} -E echo "Linux and Debian detected. Running setup script."
        )
    else()
        add_custom_command(
            OUTPUT check_env_for_deb_packing
            COMMAND ${CMAKE_COMMAND} -E echo "Linux system detected, but not Debian."
            COMMAND exit 1
        )
    endif()
else()
    add_custom_command(
        OUTPUT check_env_for_deb_packing
        COMMAND ${CMAKE_COMMAND} -E echo "Not a Linux system. This target is applicable only for Linux/Debian Host."
        COMMAND exit 1
    )
endif()


include_all_components_from_directory()

add_custom_target(build.deb.package ALL
    COMMAND ${CMAKE_COMMAND} -E echo "Building Debian package for ${APP_NAME}..."
    DEPENDS check_env_for_deb_packing
)
