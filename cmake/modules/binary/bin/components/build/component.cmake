set(ALL_TARGETS "")
set(ALL_TARGETS_VENDOR "")
foreach(GOOS ${GOOS_LIST})

    set_goos_ext(${GOOS})
    set_goos_arch_lists(${GOOS})

    set(OS_ALL_TARGETS "")
    set(OS_ALL_TARGETS_VENDOR "")
    foreach(GOARCH ${ARCH_LIST})
        map_goarch_to_arch(${GOARCH} APP_ARCH)
        
        set(PATH_OUTPUT ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${APP_ARCH}/${APP_NAME}${EXT})
        set_build_output_from_arg(BUILD_OUTPUT_PATH)
        build("${GOOS}" "${GOARCH}" "${EXT}" "${BUILD_OUTPUT_PATH}/${APP_NAME}${EXT}")
        add_custom_target(build.binary.${GOOS}.${APP_ARCH}
            DEPENDS ${PATH_OUTPUT}
        )
        list(APPEND OS_ALL_TARGETS "build.binary.${GOOS}.${APP_ARCH}")
        list(APPEND ALL_TARGETS "build.binary.${GOOS}.${APP_ARCH}")
    endforeach()
        add_custom_target(build.binary.${GOOS}.all
            DEPENDS ${OS_ALL_TARGETS}
        )
endforeach()
add_custom_target(build.binary.all
    DEPENDS ${ALL_TARGETS}
)



get_host_os(GOOS)
set_goos_ext(${GOOS})

get_host_arch(APP_ARCH)
map_arch_to_goarch(${APP_ARCH} GOARCH)


set(PATH_OUTPUT ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${APP_ARCH}/${APP_NAME}${EXT})
set_build_output_from_arg(BUILD_OUTPUT_PATH)
build("${GOOS}" "${GOARCH}" "${EXT}" "${BUILD_OUTPUT_PATH}/${APP_NAME}${EXT}")
add_custom_target(build.binary
    DEPENDS ${PATH_OUTPUT}
)

set_goos_arch_lists(${GOOS})
foreach(GOARCH ${ARCH_LIST})
    map_goarch_to_arch(${GOARCH} APP_ARCH)

    set(PATH_OUTPUT ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${APP_ARCH}/${APP_NAME}${EXT})
    set_build_output_from_arg(BUILD_OUTPUT_PATH)
    build("${GOOS}" "${GOARCH}" "${EXT}" "${BUILD_OUTPUT_PATH}/${APP_NAME}${EXT}")
    add_custom_target(build.binary.${APP_ARCH}
        DEPENDS ${PATH_OUTPUT}
    )
endforeach()