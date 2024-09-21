cmake_minimum_required(VERSION 3.10)

project(Pars)

set(TARGET_NAME pars)
set(APP_TAG v1.0.3-test.13)

set(GOOS_LIST "linux" "darwin" "windows" "freebsd")

find_program(GO_EXEC go)
if(NOT GO_EXEC)
    message(FATAL_ERROR "Go executable not found!")
endif()

foreach(GOOS ${GOOS_LIST})
    if(${GOOS} STREQUAL "windows")
        set(EXT ".exe")
    else()
        set(EXT "") 
    endif()


    if(WIN32)
        # Set environment variables using PowerShell
        # set(GO_BUILD_ENV_COMMAND $$env:GOOS='${GOOS}'; $$env:GOARCH='amd64';)
    else()
        # Set environment variables for other platforms (Linux, macOS, etc.)
        set(GO_BUILD_ENV_COMMAND "GOOS=${GOOS} GOARCH=${GOARCH}")
    endif()
    
    # Ensure GOOS and GOARCH are set for all platforms
    set(ENV{GOOS} ${GOOS})
    set(ENV{GOARCH} ${GOARCH})
    
    add_custom_command(
        OUTPUT ${CMAKE_BINARY_DIR}/${GOOS}/${TARGET_NAME}${EXT}
        COMMAND powershell.exe -ExecutionPolicy Bypass -Command \"${GO_BUILD_ENV_COMMAND} go build
        -ldflags=\\"-X 'parsdevkit.net/core/utils.version=${APP_TAG}' -X 'parsdevkit.net/core/utils.stage=final' -buildid=pars\\"
        -o ${CMAKE_BINARY_DIR}/${GOOS}/${TARGET_NAME}${EXT}
        ./pars.go\"
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/src
        COMMENT "Building for ${GOOS} ${GOARCH} with tag ${APP_TAG}..."
    )
    

    add_custom_target(${TARGET_NAME}_${GOOS}
        DEPENDS ${CMAKE_BINARY_DIR}/${GOOS}/${TARGET_NAME}${EXT}
    )
endforeach()

add_custom_target(build_all
    DEPENDS ${TARGET_NAME}_linux ${TARGET_NAME}_darwin ${TARGET_NAME}_windows ${TARGET_NAME}_freebsd
)

if(WIN32)
    set(OS_NAME "Windows")
elseif(APPLE)
    set(OS_NAME "macOS")
elseif(UNIX)
    set(OS_NAME "Linux or BSD")
else()
    set(OS_NAME "Unknown OS")
endif()

# Çıktı almak için bir hedef oluştur
add_custom_target(hello
    COMMAND ${CMAKE_COMMAND} -E echo "Hello from ${OS_NAME}"
)