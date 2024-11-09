get_host_os(HOST_OS)
set(CMAKE_SOURCE_DIR_PATH ${CMAKE_SOURCE_DIR})
set(COMMON_VARIABLES 
    PROJECT_NAME
    APP_NAME
    APP_TAG
    RAW_VERSION
    DEB_SERIES
    CHANGELOG_PATH              # d
    DEB_PACK_TYPE
    PROJECT_GIT
    PROJECT_MAINTANER
    RELEASE_DATE_DEB
    PROJECT_HOMEPAGE
    PROJECT_DESCRIPTION
    LINUX_APP_BINARY_DIR
    LINUX_APP_DATA_DATABASE_DIR
    CMAKE_SOURCE_DIR_PATH
    DIST_ROOT_DIR
    GOOS
    EXT
    )


file(GLOB_RECURSE DEBIAN_FILES "${CMAKE_CURRENT_LIST_DIR}/debian-files/*")

foreach(DEBARCH ${ALL_DEBARCH_LIST_LINUX})
    map_debarch_to_arch_all(${DEBARCH} APP_ARCH)
    
    set(DEB_ROOT_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/pkg/${APP_ARCH})
    set(DEB_PAYLOAD_DIR ${DEB_ROOT_DIR}/${APP_NAME})
    set(DEB_OUTPUT_DIR ${DEB_ROOT_DIR}/output)
    set(DEB_CONF_DIR ${DEB_ROOT_DIR}/${APP_NAME}/debian)

    if(${DEBARCH} STREQUAL ${DEB_ARCH_ALL})
        get_host_arch(HOST_ARCH)
        set(BIN_OUTPUT_FULL_PATH ${DEB_OUTPUT_DIR}/${APP_NAME}/dist/${APP_TAG}/${HOST_OS}/bin/${HOST_ARCH}/${APP_NAME}${EXT})
    else()
        set(BIN_OUTPUT_FULL_PATH ${DEB_OUTPUT_DIR}/${APP_NAME}/dist/${APP_TAG}/${HOST_OS}/bin/${APP_ARCH}/${APP_NAME}${EXT})
    endif()


    list(APPEND COMMON_VARIABLES APP_ARCH)
    list(APPEND COMMON_VARIABLES DEBARCH)
    list(APPEND COMMON_VARIABLES BIN_OUTPUT_FULL_PATH)

    set(DEBIAN_FILE_NAMES "")
    foreach(DEBIANFILE ${DEBIAN_FILES})
        file(RELATIVE_PATH REL_FILE_PATH "${CMAKE_CURRENT_LIST_DIR}/debian-files" ${DEBIANFILE})

        set(CONFIG_FILE_PATH "${DEB_CONF_DIR}/${REL_FILE_PATH}")
        list(APPEND DEBIAN_FILE_NAMES ${CONFIG_FILE_PATH})
        list(APPEND COMMON_VARIABLES CONFIG_FILE_PATH)

        var_list_to_cmake_args(VARIABLES_TO_PASS "${COMMON_VARIABLES}")
        add_custom_command(
            OUTPUT ${CONFIG_FILE_PATH}
            COMMAND ${CMAKE_COMMAND} -E echo "Generating ${DEBIANFILE} file..."
            COMMAND ${CMAKE_COMMAND} ${VARIABLES_TO_PASS}  -P "${DEBIANFILE}"
            COMMENT "Generating ${DEBIANFILE} to ${CONFIG_FILE_PATH}"
        )
    endforeach()

    add_custom_target(build.deb.package.${APP_ARCH}.configuration DEPENDS check_env_for_deb_packing ${DEBIAN_FILE_NAMES})
endforeach()