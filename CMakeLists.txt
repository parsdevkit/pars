cmake_minimum_required(VERSION 3.22)
find_program(GO_EXEC go)
if(NOT GO_EXEC)
    message(FATAL_ERROR "Go executable not found!")
endif()


project(Pars)

include(${CMAKE_SOURCE_DIR}/cmake/CMakeTemplates.cmake)

