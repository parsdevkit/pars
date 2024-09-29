include("${CMAKE_SOURCE_DIR}/cmake/core/detect-os.cmake")

set(CHANNEL test)
set(CHANNEL_NUMBER_FILE .channel_number)

execute_process(
    COMMAND git describe --tags --abbrev=0
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_TAG
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND git rev-list ${GIT_TAG}..HEAD --count
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE COMMITS_SINCE_TAG
    OUTPUT_STRIP_TRAILING_WHITESPACE
)


execute_process(
    COMMAND git show -s --format=%ci ${GIT_TAG}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE RELEASE_DATE
    OUTPUT_STRIP_TRAILING_WHITESPACE
)





if(IS_WINDOWS)
# CHANNEL_NUMBER
    execute_process(
        COMMAND powershell -ExecutionPolicy Bypass -NoProfile -Command "if (Test-Path '${CHANNEL_NUMBER_FILE}') { Get-Content '${CHANNEL_NUMBER_FILE}' } else { Write-Output 1 }"
        OUTPUT_VARIABLE CHANNEL_NUMBER
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
elseif(IS_UNIX_BASED)
    # CHANNEL_NUMBER
    execute_process(
        COMMAND bash -c "cat ${CHANNEL_NUMBER_FILE} 2>/dev/null || echo 1"
        OUTPUT_VARIABLE CHANNEL_NUMBER
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
endif()

if(NOT CHANNEL_NUMBER)
    set(CHANNEL_NUMBER 1)
endif()

set(APP_TAG ${GIT_TAG}-${CHANNEL}.${CHANNEL_NUMBER})


if(IS_WINDOWS)
    # RAW_VERSION
    execute_process(
        COMMAND powershell -ExecutionPolicy Bypass -NoProfile -Command "'${APP_TAG}' -replace 'v', ''"
        OUTPUT_VARIABLE RAW_VERSION
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    
    # APP_TAG_VERSION
    execute_process(
        COMMAND powershell -ExecutionPolicy Bypass -NoProfile -Command "'${RAW_VERSION}' -split '-' | Select-Object -First 1"
        OUTPUT_VARIABLE APP_TAG_VERSION
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    
    # APP_TAG_RELEASE
    execute_process(
        COMMAND powershell -ExecutionPolicy Bypass -NoProfile -Command "'${RAW_VERSION}' -split '-' | Select-Object -Last 1"
        OUTPUT_VARIABLE APP_TAG_RELEASE
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
elseif(IS_UNIX_BASED)
    # RAW_VERSION
    execute_process(
        COMMAND bash -c "echo ${APP_TAG} | sed 's/^v//'"
        OUTPUT_VARIABLE RAW_VERSION
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    # APP_TAG_VERSION
    execute_process(
        COMMAND bash -c "echo ${APP_TAG} | sed 's/^v//' | cut -d'-' -f1"
        OUTPUT_VARIABLE APP_TAG_VERSION
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    # APP_TAG_RELEASE
    execute_process(
        COMMAND bash -c "echo ${APP_TAG} | sed 's/^v//' | cut -d'-' -f2-"
        OUTPUT_VARIABLE APP_TAG_RELEASE
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
endif()



message(STATUS "CHANNEL_NUMBER: ${CHANNEL_NUMBER}")
message(STATUS "RAW_VERSION: ${RAW_VERSION}")
message(STATUS "APP_TAG_VERSION: ${APP_TAG_VERSION}")
message(STATUS "APP_TAG_RELEASE: ${APP_TAG_RELEASE}")
message(STATUS "RELEASE_DATE: ${RELEASE_DATE}")
message(STATUS "IS_WINDOWS: ${IS_WINDOWS}")