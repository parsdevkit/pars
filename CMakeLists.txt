cmake_minimum_required(VERSION 3.10)
find_program(GO_EXEC go)
if(NOT GO_EXEC)
    message(FATAL_ERROR "Go executable not found!")
endif()


project(Pars)

set(APP_NAME pars)
set(APP_TAG v1.0.3-test.13)
set(GOOS_LIST "linux" "darwin" "windows" "freebsd" "openbsd" "netbsd")
# set(GOARCH_LIST_WINDOWS "386;amd64;arm;arm64")
set(GOARCH_LIST_WINDOWS "amd64;arm64")
set(GOARCH_LIST_LINUX "386;amd64;arm;arm64")
set(GOARCH_LIST_DARWIN "amd64;arm64")
# set(GOARCH_LIST_FREEBSD "386;amd64;arm;arm64")
set(GOARCH_LIST_FREEBSD "amd64")
# set(GOARCH_LIST_NETBSD "386;amd64;arm;arm64")
set(GOARCH_LIST_NETBSD "amd64")
# set(GOARCH_LIST_OPENBSD "386;amd64;arm;arm64")
set(GOARCH_LIST_OPENBSD "amd64")

set(DIST_ROOT_DIR "dist")

include(${CMAKE_SOURCE_DIR}/cmake/build.binary.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/build.deb.package.cmake)

