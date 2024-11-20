file(APPEND ${CONFIG_FILE_PATH} "Name: ${APPLICATION_NAME}\n")
file(APPEND ${CONFIG_FILE_PATH} "Version: ${APP_TAG_VERSION}\n")
file(APPEND ${CONFIG_FILE_PATH} "Release: ${APP_TAG_RELEASE}%{?dist}\n")
file(APPEND ${CONFIG_FILE_PATH} "Summary: ${SUMMARY}\n")
file(APPEND ${CONFIG_FILE_PATH} "License: ${LICENCE_TYPE}\n")
file(APPEND ${CONFIG_FILE_PATH} "URL: ${HOMEPAGE}\n")
file(APPEND ${CONFIG_FILE_PATH} "Source0: %{name}-%{version}.tar.gz\n")
file(APPEND ${CONFIG_FILE_PATH} "BuildArch: ${RPM_PACK_ARCH}\n\n")

# Uncomment if BuildRequires is needed
# file(APPEND ${CONFIG_FILE_PATH} "BuildRequires: \n")

file(APPEND ${CONFIG_FILE_PATH} "Requires: glibc\n\n")

file(APPEND ${CONFIG_FILE_PATH} "%description\n")
file(APPEND ${CONFIG_FILE_PATH} "${DESCRIPTION}\n\n")

file(APPEND ${CONFIG_FILE_PATH} "%prep\n")
# Uncomment if specific setup is needed
# file(APPEND ${CONFIG_FILE_PATH} "%setup -q\n")
# file(APPEND ${CONFIG_FILE_PATH} "mkdir -p %{_builddir}/%{name}-%{version}\n")
# file(APPEND ${CONFIG_FILE_PATH} "tar -xzf %{SOURCE0} -C %{_builddir}/%{name}-%{version}\n")
file(APPEND ${CONFIG_FILE_PATH} "tar -xzf %{SOURCE0} -C %{_builddir}\n\n")

file(APPEND ${CONFIG_FILE_PATH} "%build\n")
file(APPEND ${CONFIG_FILE_PATH} "${MAKE} build.binary.linux.vendor TAG=${APP_TAG}\n")
file(APPEND ${CONFIG_FILE_PATH} "echo %{buildroot}\n\n")

file(APPEND ${CONFIG_FILE_PATH} "%install\n")
# Uncomment if specific build commands are needed
# file(APPEND ${CONFIG_FILE_PATH} "${MAKE} package.rpm.move-binary-to-package-source TAG=${APP_TAG} OS=${OS_LINUX} ARCH=${ARCH_FLAG_VALUE}\n")
file(APPEND ${CONFIG_FILE_PATH} "mkdir -p %{buildroot}/${LINUX_APP_BINARY_DIR}\n")
file(APPEND ${CONFIG_FILE_PATH} "mkdir -p %{buildroot}/${LINUX_APP_CONFIG_DIR}\n")
file(APPEND ${CONFIG_FILE_PATH} "mkdir -p %{buildroot}/${LINUX_APP_LOG_DIR}\n")
file(APPEND ${CONFIG_FILE_PATH} "mkdir -p %{buildroot}/${LINUX_APP_DATA_DATABASE_DIR}\n")
file(APPEND ${CONFIG_FILE_PATH} "mkdir -p %{buildroot}/${LINUX_APP_CACHE_DIR}\n")
file(APPEND ${CONFIG_FILE_PATH} "mkdir -p %{buildroot}/${LINUX_APP_LIB_DIR}\n")
file(APPEND ${CONFIG_FILE_PATH} "mkdir -p %{buildroot}/${LINUX_APP_SHARE_DIR}\n")
file(APPEND ${CONFIG_FILE_PATH} "mkdir -p %{buildroot}/${LINUX_APP_DOCS_DIR}\n")
file(APPEND ${CONFIG_FILE_PATH} "cp -r ${BIN_ROOT_DIR}/output/${APP} %{buildroot}/${LINUX_APP_BINARY_DIR}\n")
file(APPEND ${CONFIG_FILE_PATH} "cp -r ${DOCS_USER_DOCS_DIR} %{buildroot}/${LINUX_APP_DOCS_DIR}\n\n")

file(APPEND ${CONFIG_FILE_PATH} "%files\n")
file(APPEND ${CONFIG_FILE_PATH} "%{_bindir}/${APPLICATION_NAME}\n")
file(APPEND ${CONFIG_FILE_PATH} "/${LINUX_APP_DOCS_DIR}/*\n\n")

file(APPEND ${CONFIG_FILE_PATH} "%changelog\n")
file(APPEND ${CONFIG_FILE_PATH} "* ${RPM_RELEASE_DATE_FORMAT} ${MAINTANER} - ${APP_TAG}\n")

file(APPEND ${CONFIG_FILE_PATH} "
execute_process(
    COMMAND bash -c \"if [ -f ${CHANGELOG_PATH} ]; then sed 's/^\*/-/' ${CHANGELOG_PATH} >> ${CONFIG_FILE_PATH}; else echo '- Not specified any changes' >> ${CONFIG_FILE_PATH}; fi\"
)\n
")
