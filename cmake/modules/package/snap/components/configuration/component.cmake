get_host_os(HOST_OS)
set(CMAKE_SOURCE_DIR_PATH ${CMAKE_SOURCE_DIR})
set(COMMON_VARIABLES 
    PROJECT_NAME
    APP_NAME
    APP_TAG
    RAW_VERSION
    SNAP_SERIES
    SNAP_BASE
    CHANGELOG_PATH              # d
    SNAP_PACK_TYPE
    PROJECT_GIT
    PROJECT_MAINTANER
    RELEASE_DATE_SNAP
    PROJECT_HOMEPAGE
    PROJECT_DESCRIPTION
    PROJECT_SUMMARY
    LINUX_APP_BINARY_DIR
    LINUX_APP_DATA_DATABASE_DIR
    CMAKE_SOURCE_DIR_PATH
    DIST_ROOT_DIR
    GOOS
    EXT
    )


file(GLOB_RECURSE SNAP_FILES "${CMAKE_CURRENT_LIST_DIR}/snap-files/*")

foreach(SNAPARCH ${ALL_SNAPARCH_LIST_LINUX})
    map_snaparch_to_arch_all(${SNAPARCH} APP_ARCH)
    
    set(SNAP_ROOT_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/pkg/${SNAP_PACKAGE_NAME}/${APP_ARCH})
    set(SNAP_PAYLOAD_DIR ${SNAP_ROOT_DIR}/${APP_NAME})
    set(SNAP_OUTPUT_DIR ${SNAP_ROOT_DIR}/output)
    set(SNAP_CONF_DIR ${SNAP_ROOT_DIR}/${APP_NAME}/snap)

    if(${SNAPARCH} STREQUAL ${SNAP_ARCH_ALL})
        get_host_arch(HOST_ARCH)
        set(BIN_OUTPUT_FULL_PATH ${SNAP_OUTPUT_DIR}/${APP_NAME}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/bin/${HOST_ARCH}/${APP_NAME}${EXT})
    else()
        set(BIN_OUTPUT_FULL_PATH ${SNAP_OUTPUT_DIR}/${APP_NAME}/${DIST_ROOT_DIR}/${APP_TAG}/${HOST_OS}/bin/${APP_ARCH}/${APP_NAME}${EXT})
    endif()


    list(APPEND COMMON_VARIABLES APP_ARCH)
    list(APPEND COMMON_VARIABLES SNAPARCH)
    list(APPEND COMMON_VARIABLES BIN_OUTPUT_FULL_PATH)

    set(SNAP_FILE_NAMES "")
    foreach(SNAPFILE ${SNAP_FILES})
        file(RELATIVE_PATH REL_FILE_PATH "${CMAKE_CURRENT_LIST_DIR}/snap-files" ${SNAPFILE})

        set(CONFIG_FILE_PATH "${SNAP_CONF_DIR}/${REL_FILE_PATH}")
        list(APPEND SNAP_FILE_NAMES ${CONFIG_FILE_PATH})
        list(APPEND COMMON_VARIABLES CONFIG_FILE_PATH)

        var_list_to_cmake_args(VARIABLES_TO_PASS "${COMMON_VARIABLES}")
        add_custom_command(
            OUTPUT ${CONFIG_FILE_PATH}
            COMMAND ${CMAKE_COMMAND} -E echo "Generating ${SNAPFILE} file..."
            COMMAND ${CMAKE_COMMAND} ${VARIABLES_TO_PASS}  -P "${SNAPFILE}"
            COMMENT "Generating ${SNAPFILE} to ${CONFIG_FILE_PATH}"
        )
    endforeach()

    add_custom_target(build.snap.package.${APP_ARCH}.configuration DEPENDS check_env_for_snap_packing ${SNAP_FILE_NAMES})
endforeach()