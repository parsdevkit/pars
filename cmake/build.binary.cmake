set(BUILD_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${GOARCH}/${APP_NAME})

function(set_go_env_and_build GOOS GOARCH EXT)
    if(WIN32)
        set(GO_BUILD_ENV_COMMAND "$$env:GOOS='${GOOS}'\; $$env:GOARCH='${GOARCH}'\;")
        set(GO_BUILD_COMMAND powershell.exe -ExecutionPolicy Bypass -Command "${GO_BUILD_ENV_COMMAND} go build -ldflags='-X parsdevkit.net/core/utils.version=${APP_TAG} -X parsdevkit.net/core/utils.stage=final -buildid=${APP_NAME}' -o ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${GOARCH}/${APP_NAME}${EXT} ./pars.go")
        set(GO_BUILD_EXEC "${GO_BUILD_COMMAND}")
    else()
        set(GO_BUILD_ENV_COMMAND GOOS=${GOOS} GOARCH=${GOARCH})
        set(GO_BUILD_COMMAND ${GO_BUILD_ENV_COMMAND} go build -ldflags='-X parsdevkit.net/core/utils.version=${APP_TAG} -X parsdevkit.net/core/utils.stage=final -buildid=${APP_NAME}' -o ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${GOARCH}/${APP_NAME}${EXT} ./pars.go)
        set(GO_BUILD_EXEC ${GO_BUILD_COMMAND})
    endif()

    add_custom_command(
        OUTPUT ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${GOARCH}/${APP_NAME}${EXT}
        COMMAND ${GO_BUILD_EXEC}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/src
        COMMENT "Building for ${GOOS} ${GOARCH} with tag ${APP_TAG}..."
    )
endfunction()

function(set_host_goos)    
    if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
        set(GOOS "linux" PARENT_SCOPE)
    elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
        set(GOOS "darwin" PARENT_SCOPE)
    elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
        set(GOOS "windows" PARENT_SCOPE)
    else()
        message(FATAL_ERROR "Unsupported host OS: ${CMAKE_HOST_SYSTEM_NAME}")
    endif()
endfunction()

function(set_host_goarch)
    if(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "x86_64" OR CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "AMD64")
        set(GOARCH "amd64" PARENT_SCOPE)
    elseif(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "i[3-6]86")
        set(GOARCH "386" PARENT_SCOPE)
    elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "aarch64")
        set(GOARCH "arm64" PARENT_SCOPE)
    elseif(CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "armv7l" OR CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "arm")
        set(GOARCH "arm" PARENT_SCOPE)
    else()
        message(FATAL_ERROR "Unsupported architecture: ${CMAKE_HOST_SYSTEM_PROCESSOR}")
    endif()
endfunction()
function(set_goos_ext GOOS)
    if(${GOOS} STREQUAL "windows")
        set(EXT ".exe" PARENT_SCOPE)
    elseif(${GOOS} STREQUAL "linux")
        set(EXT "" PARENT_SCOPE)
    elseif(${GOOS} STREQUAL "darwin")
        set(EXT "" PARENT_SCOPE)
    elseif(${GOOS} STREQUAL "freebsd")
        set(EXT "" PARENT_SCOPE)
    elseif(${GOOS} STREQUAL "openbsd")
        set(EXT "" PARENT_SCOPE)
    elseif(${GOOS} STREQUAL "netbsd")
        set(EXT "" PARENT_SCOPE)
    else()
        message(FATAL_ERROR "Unsupported GOOS: ${GOOS}")
    endif()
endfunction()
function(set_goos_arch_lists GOOS)
    if(${GOOS} STREQUAL "windows")
        set(ARCH_LIST "${GOARCH_LIST_WINDOWS}" PARENT_SCOPE)
    elseif(${GOOS} STREQUAL "linux")
        set(ARCH_LIST "${GOARCH_LIST_LINUX}" PARENT_SCOPE)
    elseif(${GOOS} STREQUAL "darwin")
        set(ARCH_LIST "${GOARCH_LIST_DARWIN}" PARENT_SCOPE)
    elseif(${GOOS} STREQUAL "freebsd")
        set(ARCH_LIST "${GOARCH_LIST_FREEBSD}" PARENT_SCOPE)
    elseif(${GOOS} STREQUAL "openbsd")
        set(ARCH_LIST "${GOARCH_LIST_OPENBSD}" PARENT_SCOPE)
    elseif(${GOOS} STREQUAL "netbsd")
        set(ARCH_LIST "${GOARCH_LIST_NETBSD}" PARENT_SCOPE)
    else()
        message(FATAL_ERROR "Unsupported GOOS: ${GOOS}")
    endif()
endfunction()


set(ALL_TARGETS "")
foreach(GOOS ${GOOS_LIST})

    set_goos_ext(${GOOS})
    set_goos_arch_lists(${GOOS})

    set(OS_ALL_TARGETS "")
    foreach(GOARCH ${ARCH_LIST})
        set_go_env_and_build("${GOOS}" "${GOARCH}" "${EXT}")

        add_custom_target(build.binary.${GOOS}.${GOARCH}
            DEPENDS ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${GOARCH}/${APP_NAME}${EXT}
        )
        list(APPEND OS_ALL_TARGETS "build.binary.${GOOS}.${GOARCH}")
        list(APPEND ALL_TARGETS "build.binary.${GOOS}.${GOARCH}")
    endforeach()
        add_custom_target(build.binary.${GOOS}-all
            DEPENDS ${OS_ALL_TARGETS}
        )
endforeach()
add_custom_target(build.binary-all
    DEPENDS ${ALL_TARGETS}
)



set_host_goos()
set_host_goarch()
set_goos_ext(${GOOS})
set_go_env_and_build("${GOOS}" "${GOARCH}" "${EXT}")

add_custom_target(build.binary
    DEPENDS ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${GOARCH}/${APP_NAME}${EXT}
)

set_goos_arch_lists(${GOOS})

foreach(GOARCH ${ARCH_LIST})
    set_go_env_and_build("${GOOS}" "${GOARCH}" "${EXT}")

    add_custom_target(build.binary.${GOARCH}
        DEPENDS ${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR}/${APP_TAG}/${GOOS}/bin/${GOARCH}/${APP_NAME}${EXT}
    )
endforeach()