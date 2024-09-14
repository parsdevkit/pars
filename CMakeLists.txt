cmake_minimum_required(VERSION 3.10)

project(pars)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(PLATFORM "linux")
    set(EXTENSION "")
    set(CMD "go build -o pars")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(PLATFORM "windows")
    set(EXTENSION ".exe")
    set(CMD "go build -o pars.exe")
else()
    message(FATAL_ERROR "Unsupported platform!")
endif()


set(SRC_DIR ${CMAKE_SOURCE_DIR}/src)

add_custom_target(build ALL
    COMMAND ${CMAKE_COMMAND} -E chdir ${SRC_DIR} ${CMD}
    COMMENT "Building Go project for ${PLATFORM}"
)