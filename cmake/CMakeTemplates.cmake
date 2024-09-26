include(${CMAKE_SOURCE_DIR}/cmake/CMakeVariables.cmake)


file(GLOB_RECURSE CORES "${CMAKE_SOURCE_DIR}/cmake/CORE/*.cmake")
foreach(CORE ${CORES})
    include(${CORE})
endforeach()


file(GLOB_RECURSE MODULES "${CMAKE_SOURCE_DIR}/cmake/Modules/*.cmake")
foreach(MODULE ${MODULES})
    include(${MODULE})
endforeach()


file(GLOB_RECURSE SCRIPTS "${CMAKE_SOURCE_DIR}/cmake/Scripts/*.cmake")
foreach(SCRIPT ${SCRIPTS})
    include(${SCRIPT})
endforeach()


file(GLOB_RECURSE UTILITIES "${CMAKE_SOURCE_DIR}/cmake/Utilities/*.cmake")
foreach(UTILITY ${UTILITIES})
    include(${UTILITY})
endforeach()