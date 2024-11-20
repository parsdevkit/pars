get_host_os(HOST_OS)
set(CMAKE_SOURCE_DIR_PATH ${CMAKE_SOURCE_DIR})
set(COMMON_VARIABLES 
    APP_NAME
    APP_TAG
    VERSION_SEMVER
    VERSION_CHANNEL
    VERSION_RELEASE
    PROJECT_SUMMARY
    PROJECT_LICENCE_TYPE
    PROJECT_HOMEPAGE
    PROJECT_DESCRIPTION
    )


file(GLOB_RECURSE RPM_FILES "${CMAKE_CURRENT_LIST_DIR}/rpm-files/*")

foreach(RPMARCH ${ALL_RPMARCH_LIST_LINUX})
    map_rpmarch_to_arch_all(${RPMARCH} APP_ARCH)
    
    set(RPM_ROOT_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/pkg/${RPM_PACKAGE_NAME}/${APP_ARCH})
    set(RPM_PAYLOAD_DIR ${RPM_ROOT_DIR}/${APP_NAME})
    set(RPM_OUTPUT_DIR ${RPM_ROOT_DIR}/output)
    set(RPM_CONF_DIR ${RPM_ROOT_DIR}/${APP_NAME}/rpm)

    if(${RPMARCH} STREQUAL ${RPM_ARCH_ALL})
        get_host_arch(HOST_ARCH)
        set(BIN_OUTPUT_FULL_PATH ${RPM_OUTPUT_DIR}/${APP_NAME}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/bin/${HOST_ARCH}/${APP_NAME}${EXT})
    else()
        set(BIN_OUTPUT_FULL_PATH ${RPM_OUTPUT_DIR}/${APP_NAME}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/bin/${APP_ARCH}/${APP_NAME}${EXT})
    endif()


    list(APPEND COMMON_VARIABLES APP_ARCH)
    list(APPEND COMMON_VARIABLES RPMARCH)
    list(APPEND COMMON_VARIABLES BIN_OUTPUT_FULL_PATH)

    set(RPM_FILE_NAMES "")
    foreach(RPMFILE ${RPM_FILES})
        file(RELATIVE_PATH REL_FILE_PATH "${CMAKE_CURRENT_LIST_DIR}/rpm-files" ${RPMFILE})

        set(CONFIG_FILE_PATH "${RPM_CONF_DIR}/${REL_FILE_PATH}")
        list(APPEND RPM_FILE_NAMES ${CONFIG_FILE_PATH})
        list(APPEND COMMON_VARIABLES CONFIG_FILE_PATH)
        message(STATUS "QQQQQ: ${CONFIG_FILE_PATH}")

        var_list_to_cmake_args(VARIABLES_TO_PASS "${COMMON_VARIABLES}")
        add_custom_command(
            OUTPUT ${CONFIG_FILE_PATH}
            COMMAND ${CMAKE_COMMAND} -E echo "Generating ${RPMFILE} file..."
            COMMAND ${CMAKE_COMMAND} ${VARIABLES_TO_PASS}  -P "${RPMFILE}"
            COMMENT "Generating ${RPMFILE} to ${CONFIG_FILE_PATH}"
        )
    endforeach()

    add_custom_target(build.rpm.package.${APP_ARCH}.configuration DEPENDS check_env_for_rpm_packing ${RPM_FILE_NAMES})
endforeach()