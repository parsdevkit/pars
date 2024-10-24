# Varsayılan değerler
set(DEFAULT_VERSION "0.1.0")
set(DEFAULT_CHANNEL "beta")
set(DEFAULT_REVISION "0")
set(DEFAULT_DATE "")
set(DEFAULT_VERSION_PREFIX "")

execute_process(
    COMMAND date "+%Y.%m.%d"
    OUTPUT_VARIABLE CURRENT_DATE
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
set(DEFAULT_DATE ${CURRENT_DATE})

if(NOT GIT_TAG_FOUND EQUAL 0)
    message(STATUS "No Git tag found, using default values.")
    set(VERSION ${DEFAULT_VERSION})
    set(CHANNEL ${DEFAULT_CHANNEL})
    set(REVISION ${DEFAULT_REVISION})
    set(DATE ${DEFAULT_DATE})
else()

    execute_process(
        COMMAND git describe --tags --abbrev=0
        RESULT_VARIABLE GIT_TAG_FOUND
        OUTPUT_VARIABLE GIT_TAG
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    string(REGEX MATCH "^[A-Za-z]*([0-9]+\\.[0-9]+\\.[0-9]+)$" VERSION_MATCH ${GIT_TAG})
    if(VERSION_MATCH)
        set(VERSION ${CMAKE_MATCH_1})
    else()
        message(FATAL_ERROR "Invalid version format in Git tag.")
    endif()

    string(REGEX MATCH "([A-Za-z]+)?[0-9]+\\.[0-9]+\\.[0-9]+$" PREFIX_MATCH ${GIT_TAG})
    if(PREFIX_MATCH)
        set(VERSION_PREFIX ${CMAKE_MATCH_1})
    else()
        set(VERSION_PREFIX ${DEFAULT_VERSION_PREFIX})
    endif()

    string(REGEX MATCH "[-]([a-zA-Z]+)" CHANNEL_MATCH ${GIT_TAG})
    if(CHANNEL_MATCH)
        set(CHANNEL ${CMAKE_MATCH_1})
    else()
        set(CHANNEL ${DEFAULT_CHANNEL})
    endif()

    string(REGEX MATCH "[+]([0-9]+)" REVISION_MATCH ${GIT_TAG})
    if(REVISION_MATCH)
        set(REVISION ${CMAKE_MATCH_1})
    else()
        set(REVISION ${DEFAULT_REVISION})
    endif()

    # Git commit tarihini DATE olarak kullan
    execute_process(
        COMMAND git log -1 --format=%cd --date=short
        OUTPUT_VARIABLE GIT_COMMIT_DATE
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set(DATE ${GIT_COMMIT_DATE})
    string(REGEX REPLACE "-" "." DATE "${DATE}")
    message(STATUS "Git tag found: ${GIT_TAG} (${DATE})")
endif()

string(REGEX MATCH "^20[0-9][0-9]\\.(0?[1-9]|1[012])\\.(0?[1-9]|[12][0-9]|3[01])$" DATE_MATCH ${DATE})
if(NOT DATE_MATCH)
    message(FATAL_ERROR "Invalid date format. Expected yyyy-mm-dd, but got: '${DATE}'")
endif()


message(STATUS "Version Prefix: ${VERSION_PREFIX}")
message(STATUS "Version: ${VERSION}")
message(STATUS "Channel: ${CHANNEL}")
message(STATUS "Revision: ${REVISION}")
message(STATUS "Date: ${DATE}")


# make komutunda argümanlar varsa onları geçerli kılalım
function(set_version VERSION_ARG DATE_ARG CHANNEL_ARG REVISION_ARG)
    if(VERSION_ARG)
        set(VERSION ${VERSION_ARG})
    endif()

    # SemVer uyumunu kontrol edelim, prefix'i ayıralım
    string(REGEX MATCH "[A-Za-z]*([0-9]+\\.[0-9]+\\.[0-9]+)(\\.[0-9]+)?" VERSION_MATCH ${VERSION})
    if(NOT VERSION_MATCH)
        message(FATAL_ERROR "Invalid VERSION format.")
    endif()

    # VERSION_PREFIX varsa ayıralım
    string(REGEX MATCH "^[A-Za-z]*" VERSION_PREFIX_MATCH ${VERSION})
    if(VERSION_PREFIX_MATCH)
        set(VERSION_PREFIX "vVVVVVV")
    endif()

    # Eğer VERSION "1.0.0.1" gibi 4 parçadan oluşuyorsa son parçayı REVISION olarak ayıralım
    string(REGEX MATCH "([0-9]+)\\.[0-9]+\\.[0-9]+\\.[0-9]+" FOUR_PART_VERSION_MATCH ${VERSION})
    if(FOUR_PART_VERSION_MATCH)
        string(REGEX REPLACE "^([0-9]+\\.[0-9]+\\.[0-9]+)\\.([0-9]+)" "\\1" VERSION ${VERSION})
        string(REGEX REPLACE "^([0-9]+\\.[0-9]+\\.[0-9]+)\\.([0-9]+)" "\\2" REVISION ${VERSION})
    endif()

    # DATE argümanı varsa formatını kontrol edelim
    if(DATE_ARG)
        if(NOT DATE_ARG MATCHES "^\\d{4}\\.\\d{2}\\.\\d{2}$")
            message(FATAL_ERROR "Invalid date format. Expected yyyy.mm.dd")
        endif()
        set(DATE ${DATE_ARG})
    endif()

    # Channel ve Revision'ı güncelleyelim
    if(CHANNEL_ARG)
        set(CHANNEL ${CHANNEL_ARG})
    endif()
    if(REVISION_ARG)
        set(REVISION ${REVISION_ARG})
    endif()

    message(STATUS "VERSION: ${VERSION}")
    message(STATUS "VERSION_PREFIX: ${VERSION_PREFIX}")
    message(STATUS "CHANNEL: ${CHANNEL}")
    message(STATUS "REVISION: ${REVISION}")
    message(STATUS "DATE: ${DATE}")
endfunction()



add_custom_target(release.version.get
    COMMAND ${CMAKE_COMMAND} -DVERSION=$(VERSION) -DCHANNEL=$(CHANNEL) -DREVISION=${REVISION} -DDATE=${DATE} -P ${CMAKE_SOURCE_DIR}/cmake/modules/release/version/components/bump/print_version.cmake
)
