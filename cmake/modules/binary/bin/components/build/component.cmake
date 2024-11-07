set(ALL_TARGETS "")
set(ALL_TARGETS_VENDOR "")
foreach(GOOS ${GOOS_LIST})

    set_goos_ext(${GOOS})
    set_goos_arch_lists(${GOOS})

    set(OS_ALL_TARGETS "")
    set(OS_ALL_TARGETS_VENDOR "")
    foreach(GOARCH ${ARCH_LIST})
        map_goarch_to_arch(${GOARCH} APP_ARCH)
        
        set_build_output_from_arg("${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${APP_ARCH}/${APP_NAME}${EXT}" "${GOOS}_${APP_ARCH}_${APP_TAG}_${APP_NAME}${EXT}" BUILD_OUTPUT_PATH)
        build("${GOOS}" "${GOARCH}" "${EXT}" OFF "${BUILD_OUTPUT_PATH}")
        add_custom_target(build.binary.${GOOS}.${APP_ARCH}
            DEPENDS ${BUILD_OUTPUT_PATH}
        )
        list(APPEND OS_ALL_TARGETS "build.binary.${GOOS}.${APP_ARCH}")
        list(APPEND ALL_TARGETS "build.binary.${GOOS}.${APP_ARCH}")

        
        set_build_output_from_arg("${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/v_${APP_ARCH}/${APP_NAME}${EXT}" "v_${GOOS}_${APP_ARCH}_${APP_TAG}_${APP_NAME}${EXT}" BUILD_OUTPUT_PATH)
        build("${GOOS}" "${GOARCH}" "${EXT}" ON "${BUILD_OUTPUT_PATH}")
        add_custom_target(build.binary.vendor.${GOOS}.${APP_ARCH}
            DEPENDS ${BUILD_OUTPUT_PATH}
        )
        list(APPEND OS_ALL_TARGETS_VENDOR "build.binary.vendor.${GOOS}.${APP_ARCH}")
        list(APPEND ALL_TARGETS_VENDOR "build.binary.vendor.${GOOS}.${APP_ARCH}")
    endforeach()
        add_custom_target(build.binary.${GOOS}.all
            DEPENDS ${OS_ALL_TARGETS}
        )
        add_custom_target(build.binary.vendor.${GOOS}.all
            DEPENDS ${OS_ALL_TARGETS_VENDOR}
        )
endforeach()
add_custom_target(build.binary.all
    DEPENDS ${ALL_TARGETS}
)
add_custom_target(build.binary.vendor.all
    DEPENDS ${ALL_TARGETS_VENDOR}
)



get_host_os(GOOS)
set_goos_ext(${GOOS})

get_host_arch(APP_ARCH)
map_arch_to_goarch(${APP_ARCH} GOARCH)


set_build_output_from_arg("${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${APP_ARCH}/${APP_NAME}${EXT}" "${GOOS}_${APP_ARCH}_${APP_TAG}_${APP_NAME}${EXT}" BUILD_OUTPUT_PATH)
build("${GOOS}" "${GOARCH}" "${EXT}" OFF "${BUILD_OUTPUT_PATH}")
add_custom_target(build.binary
    DEPENDS ${BUILD_OUTPUT_PATH}
)

set_build_output_from_arg("${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/v_${APP_ARCH}/${APP_NAME}${EXT}" "v_${GOOS}_${APP_ARCH}_${APP_TAG}_${APP_NAME}${EXT}" BUILD_OUTPUT_PATH)
build("${GOOS}" "${GOARCH}" "${EXT}" ON "${BUILD_OUTPUT_PATH}")
add_custom_target(build.binary.vendor
    DEPENDS ${BUILD_OUTPUT_PATH}
)

set_goos_arch_lists(${GOOS})
foreach(GOARCH ${ARCH_LIST})
    map_goarch_to_arch(${GOARCH} APP_ARCH)

    set_build_output_from_arg("${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${APP_ARCH}/${APP_NAME}${EXT}" "${GOOS}_${APP_ARCH}_${APP_TAG}_${APP_NAME}${EXT}" BUILD_OUTPUT_PATH)
    build("${GOOS}" "${GOARCH}" "${EXT}" OFF "${BUILD_OUTPUT_PATH}")
    add_custom_target(build.binary.${APP_ARCH}
        DEPENDS ${BUILD_OUTPUT_PATH}
    )

    set_build_output_from_arg("${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/v_${APP_ARCH}/${APP_NAME}${EXT}" "v_${GOOS}_${APP_ARCH}_${APP_TAG}_${APP_NAME}${EXT}" BUILD_OUTPUT_PATH)
    build("${GOOS}" "${GOARCH}" "${EXT}" ON "${BUILD_OUTPUT_PATH}")
    add_custom_target(build.binary.vendor.${APP_ARCH}
        DEPENDS ${BUILD_OUTPUT_PATH}
    )
endforeach()