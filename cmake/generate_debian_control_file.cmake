# Set variables for the control file content
set(DEB_BUILD_CONFIG_DIR "${CMAKE_BINARY_DIR}/debian")
set(CONTROL_FILE "${DEB_BUILD_CONFIG_DIR}/control")

# Ensure the debian directory exists
file(MAKE_DIRECTORY ${DEB_BUILD_CONFIG_DIR})

# Write the control file
file(WRITE ${CONTROL_FILE} "Source: ${APPLICATION_NAME}\n")
file(APPEND ${CONTROL_FILE} "Section: utils\n")
file(APPEND ${CONTROL_FILE} "Priority: optional\n")

# Correctly format the Maintainer field with escaped characters
file(APPEND ${CONTROL_FILE} "Maintainer: \"${MAINTANER}\"\n")

file(APPEND ${CONTROL_FILE} "Build-Depends: debhelper (>= 12), dh-golang, golang-any\n")
file(APPEND ${CONTROL_FILE} "Standards-Version: 4.5.0\n")
file(APPEND ${CONTROL_FILE} "Homepage: ${HOMEPAGE}\n")

# Add a blank line
file(APPEND ${CONTROL_FILE} "\n")

# Append package-specific details
file(APPEND ${CONTROL_FILE} "Package: ${APPLICATION_NAME}\n")
file(APPEND ${CONTROL_FILE} "Architecture: ${DEB_PACK_ARCH}\n")
file(APPEND ${CONTROL_FILE} "Depends: \${shlibs:Depends}, \${misc:Depends}, libc6, ca-certificates\n")
file(APPEND ${CONTROL_FILE} "Description: ${DESCRIPTION}\n")
