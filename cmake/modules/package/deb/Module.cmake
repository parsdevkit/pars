


add_custom_target(build.deb.package ALL
    COMMAND ${CMAKE_COMMAND} -E echo "Building Debian package for ${APP_NAME}..."
    DEPENDS check_env_for_deb_packing
)

include_all_components_from_directory()