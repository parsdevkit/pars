# make komutunda argümanlar varsa onları geçerli kılalım
function(generate_version_info DIST_ROOT)
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

    execute_process(
        COMMAND git describe --tags --abbrev=0
        RESULT_VARIABLE GIT_TAG_FOUND
        OUTPUT_VARIABLE GIT_TAG
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(NOT GIT_TAG_FOUND EQUAL 0)
        message(STATUS "No Git tag found, using default values.")
        set(GIT_VERSION ${DEFAULT_VERSION})
        set(GIT_CHANNEL ${DEFAULT_CHANNEL})
        set(GIT_REVISION ${DEFAULT_REVISION})
        set(GIT_DATE ${DEFAULT_DATE})
    else()
        string(REGEX MATCH "^[A-Za-z]*([0-9]+\\.[0-9]+\\.[0-9]+)$" GIT_VERSION_MATCH ${GIT_TAG})
        if(GIT_VERSION_MATCH)
            set(GIT_VERSION ${CMAKE_MATCH_1})
        else()
            message(FATAL_ERROR "Invalid version format in Git tag.")
        endif()

        string(REGEX MATCH "([A-Za-z]+)?[0-9]+\\.[0-9]+\\.[0-9]+$" PREFIX_MATCH ${GIT_TAG})
        if(PREFIX_MATCH)
            set(GIT_VERSION_PREFIX ${CMAKE_MATCH_1})
        else()
            set(GIT_VERSION_PREFIX ${DEFAULT_VERSION_PREFIX})
        endif()

        string(REGEX MATCH "[-]([a-zA-Z]+)" GIT_CHANNEL_MATCH ${GIT_TAG})
        if(GIT_CHANNEL_MATCH)
            set(GIT_CHANNEL ${CMAKE_MATCH_1})
        else()
            set(GIT_CHANNEL ${DEFAULT_CHANNEL})
        endif()

        string(REGEX MATCH "[+]([0-9]+)" GIT_REVISION_MATCH ${GIT_TAG})
        if(GIT_REVISION_MATCH)
            set(GIT_REVISION ${CMAKE_MATCH_1})
        else()
            set(GIT_REVISION ${DEFAULT_REVISION})
        endif()

        execute_process(
            COMMAND git log -1 --format=%cd --date=short
            OUTPUT_VARIABLE GIT_COMMIT_DATE
            OUTPUT_STRIP_TRAILING_WHITESPACE
        )
        set(GIT_DATE ${GIT_COMMIT_DATE})
        string(REGEX REPLACE "-" "." GIT_DATE "${GIT_DATE}")
        message(STATUS "Git tag found: ${GIT_TAG} (${GIT_DATE})")
    endif()

    string(REGEX MATCH "^20[0-9][0-9]\\.(0?[1-9]|1[012])\\.(0?[1-9]|[12][0-9]|3[01])$" GIT_DATE_MATCH ${GIT_DATE})
    if(NOT GIT_DATE_MATCH)
        message(FATAL_ERROR "Invalid date format. Expected yyyy-mm-dd, but got: '${GIT_DATE}'")
    endif()

    # Değerlerin dışarı aktarılması için set kullanıyoruz
    set(VERSION_PREFIX ${GIT_VERSION_PREFIX} PARENT_SCOPE)
    set(VERSION ${GIT_VERSION} PARENT_SCOPE)
    set(CHANNEL ${GIT_CHANNEL} PARENT_SCOPE)
    set(REVISION ${GIT_REVISION} PARENT_SCOPE)
    set(DATE ${GIT_DATE} PARENT_SCOPE)
endfunction()


set(DIST_ROOT "/path/to/distribution")
generate_version_info(${DIST_ROOT})
 

# Fonksiyon içinde APP_TAG_CURRENT oluşturulması
set(APP_TAG_CURRENT "${VERSION_PREFIX}${VERSION}-${CHANNEL}.${REVISION}")
message(STATUS "Version Prefix: ${VERSION_PREFIX}")
message(STATUS "Version: ${VERSION}")
message(STATUS "Channel: ${CHANNEL}")
message(STATUS "Revision: ${REVISION}")
message(STATUS "Date: ${DATE}")

# Klasör oluşturma
# file(MAKE_DIRECTORY ${DIST_ROOT}/${APP_TAG_CURRENT})
message(STATUS "App Tag Current: ${ROOT}")

# add_custom_target(release.version.get
#     COMMAND ${CMAKE_COMMAND} -DDIST_ROOT=${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR} -DVERSION_PREFIX=$(VERSION_PREFIX) -DVERSION=$(VERSION) -DCHANNEL=$(CHANNEL) -DREVISION=${REVISION} -DDATE=${DATE} -P ${CMAKE_CURRENT_SOURCE_DIR}/components/bump/print_version.cmake
# )