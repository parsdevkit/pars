cmake_minimum_required(VERSION 3.22)
project(Pars)

find_program(GO_EXEC go)
if(NOT GO_EXEC)
    message(FATAL_ERROR "Go executable not found!")
endif()

find_program(GIT_EXEC git)
if(NOT GIT_EXEC)
    message(FATAL_ERROR "Git executable not found!")
endif()

include("${CMAKE_SOURCE_DIR}/cmake/core/version.cmake")
if(NOT DEFINED VERSION OR VERSION STREQUAL "")
    set(VERSION "NONE")
endif()
generate_version_info(${VERSION} APP_TAG)


string(REGEX MATCH "^([A-Za-z]*)([0-9]+\\.[0-9]+\\.[0-9]+)([-]([a-zA-Z]+)([\.]?([0-9]+))?)?$" VERSION_MATCH ${APP_TAG})
if(VERSION_MATCH)
    set(VERSION_PREFIX ${CMAKE_MATCH_1})
    set(VERSION_SEMVER ${CMAKE_MATCH_2})
    set(VERSION_CHANNEL ${CMAKE_MATCH_4})
    set(VERSION_RELEASE ${CMAKE_MATCH_6})
else()
    message(FATAL_ERROR "Invalid version format: ${APP_TAG}")
endif()
    
message(STATUS "APP_TAG: ${APP_TAG}")
message(STATUS "VERSION_PREFIX: ${VERSION_PREFIX}")
message(STATUS "VERSION_SEMVER: ${VERSION_SEMVER}")
message(STATUS "VERSION_CHANNEL: ${VERSION_CHANNEL}")
message(STATUS "VERSION_RELEASE: ${VERSION_RELEASE}")

set(RAW_VERSION "${VERSION_SEMVER}")

if(DEFINED VERSION_CHANNEL AND NOT "${VERSION_CHANNEL}" STREQUAL "")
    set(RAW_VERSION "${RAW_VERSION}-${VERSION_CHANNEL}")
endif()

if(DEFINED VERSION_RELEASE AND NOT "${VERSION_RELEASE}" STREQUAL "")
    set(RAW_VERSION "${RAW_VERSION}.${VERSION_RELEASE}")
endif()
message(STATUS "RAW_VERSION: ${RAW_VERSION}")

if(NOT DEFINED RELEASE_DATE OR RELEASE_DATE STREQUAL "")

    execute_process(
        COMMAND git log -1 --format=%cd --date=short
        OUTPUT_VARIABLE GIT_COMMIT_DATE
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set(GIT_DATE ${GIT_COMMIT_DATE})

    set(RELEASE_DATE ${GIT_DATE})

endif()

add_subdirectory(cmake)