set(COMMON_VARIABLES 
    PROJECT_NAME
    APP_NAME
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
    )

file(GLOB_RECURSE DEBIAN_FILES "${CMAKE_CURRENT_LIST_DIR}/debian-files/*")
foreach(DEBARCH ${DEBARCH_LIST_LINUX})
    map_debarch_to_arch(${DEBARCH} APP_ARCH)
    list(APPEND COMMON_VARIABLES DEBARCH)

    set(DEB_CONF_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/linux/pkg/${APP_ARCH}/${APP_NAME}/debian)
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


set(DEBARCH any)
list(APPEND COMMON_VARIABLES DEBARCH)

set(DEB_CONF_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/linux/pkg/all/${APP_NAME}/debian)
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

add_custom_target(build.deb.package.all.configuration DEPENDS check_env_for_deb_packing ${DEBIAN_FILE_NAMES})