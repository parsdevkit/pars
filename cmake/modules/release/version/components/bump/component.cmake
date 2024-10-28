# make komutunda argümanlar varsa onları geçerli kılalım


# set(DIST_ROOT "/path/to/distribution")
# generate_version_info(${DIST_ROOT})
 

# Fonksiyon içinde APP_TAG_CURRENT oluşturulması
message(STATUS "Version Prefix: ${VERSION_PREFIX}")
message(STATUS "Version: ${VERSION}")
message(STATUS "Channel: ${CHANNEL}")
message(STATUS "Revision: ${REVISION}")
message(STATUS "Date: ${DATE}")

# Klasör oluşturma
# file(MAKE_DIRECTORY ${DIST_ROOT}/${APP_TAG_CURRENT})
message(STATUS "App Tag Current: ${APP_TAG_CURRENT}")

# add_custom_target(release.version
#     COMMAND ${CMAKE_COMMAND} -DDIST_ROOT=${CMAKE_SOURCE_DIR}/${DIST_ROOT_DIR} -DVERSION_PREFIX=$(VERSION_PREFIX) -DVERSION=$(VERSION) -DCHANNEL=$(CHANNEL) -DREVISION=${REVISION} -DDATE=${DATE} -P ${CMAKE_CURRENT_SOURCE_DIR}/components/bump/print_version.cmake
# )
