set(PACKAGE_ROOT_DIR "${CMAKE_BINARY_DIR}/linux/pkg/deb/${APP_ARCH}/${APP_NAME}/deb")
set(DEB_ROOT_DIR "${CMAKE_BINARY_DIR}/debian")
set(DEB_BUILD_CONFIG_DIR "${CMAKE_BINARY_DIR}/debian")



function(determine_deb_arch package_type deb_arch output_arch)
    if(NOT "${deb_arch}" STREQUAL "")
        map_arch_to_debarch("${deb_arch}" result_arch)
    else()
        if("${package_type}" STREQUAL "binary")
            map_arch_to_debarch("${APP_ARCH}" result_arch)
        else()
            set(result_arch "any")
        endif()
    endif()
    set(${output_arch} ${result_arch} PARENT_SCOPE)
endfunction()

# determine_deb_arch("${DEB_PACK_TYPE}" DEB_PACK_ARCH)
# message(WARNING "Debian Package Architecture: ${DEB_PACK_ARCH}")



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




add_custom_target(build.deb.package ALL
    COMMAND ${CMAKE_COMMAND} -E make_directory ${DEB_BUILD_CONFIG_DIR}
    COMMAND ${CMAKE_COMMAND} -E echo "Building Debian package for ${APP_NAME}..."
    COMMAND ${CMAKE_COMMAND} -E echo "Generating debian/control file..."
    COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --green "Generating control file in ${DEB_BUILD_CONFIG_DIR}..."
    DEPENDS check_env_for_deb_packing
)




set(PACKAGES
    build-essential
    devscripts
    dh-make
    debhelper
    lintian
    fakeroot
    cmake
)

add_custom_target(build.deb.package.setup
    COMMAND ${CMAKE_COMMAND} -E echo "Setting up the host machine for package build..."
    
    COMMAND sudo apt-get update && sudo apt-get install -y ${PACKAGES}

    DEPENDS check_env_for_deb_packing
)




set(MY_VARIABLES 
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


macro(collect_vars result)
    set(vars "")
    foreach(var ${ARGN})
        list(APPEND vars "-D${var}=${${var}} ")
    endforeach()
    set(${result} "${vars}")
endmacro()

collect_vars(VARIABLES_TO_PASS ${MY_VARIABLES})



file(GLOB_RECURSE DEBIAN_FILES "${CMAKE_CURRENT_LIST_DIR}/debian-files/*")



foreach(DEBARCH ${DEBARCH_LIST_LINUX})
    map_debarch_to_arch(${DEBARCH} APP_ARCH)
    

    set(DEB_CONF_DIR ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/linux/pkg/${APP_ARCH}/${APP_NAME}/debian)
    set(DEBIAN_FILE_NAMES "")
    foreach(DEBIANFILE ${DEBIAN_FILES})
        file(RELATIVE_PATH REL_FILE_PATH "${CMAKE_CURRENT_LIST_DIR}/debian-files" ${DEBIANFILE})

        set(NEW_FILE_PATH "${DEB_CONF_DIR}/${REL_FILE_PATH}")
        list(APPEND DEBIAN_FILE_NAMES ${NEW_FILE_PATH})

        add_custom_command(
            OUTPUT ${NEW_FILE_PATH}
            COMMAND ${CMAKE_COMMAND} -E echo "Generating ${DEBIANFILE} file..."
            COMMAND ${CMAKE_COMMAND} ${VARIABLES_TO_PASS} -DFILE_WRITE_PATH=${NEW_FILE_PATH} -DDEBARCH=${DEBARCH} -P "${DEBIANFILE}"
            COMMENT "Generating ${DEBIANFILE} to ${NEW_FILE_PATH}"
        )
    endforeach()

    # add_custom_target(build.deb.package.configuration ALL DEPENDS check_env_for_deb_packing ${DEBIAN_FILE_NAMES})
    add_custom_target(build.deb.package.${APP_ARCH}.configuration ALL DEPENDS ${DEBIAN_FILE_NAMES})
endforeach()



