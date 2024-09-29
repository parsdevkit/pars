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


add_subdirectory(cmake)
