get_host_os(HOST_OS)

set(ARCHIVE_TAR_GZ_EXT ".tar.gz")
set(ARCHIVE_TAR_BZ2_EXT ".tar.bz2")
set(ARCHIVE_TAR_XZ_EXT ".tar.xz")
set(ARCHIVE_ZIP_EXT ".zip")
set(ARCHIVE_RAR_EXT ".rar")
set(ARCHIVE_SEVEN_Z_EXT ".7z")
set(ARCHIVE_LZ_EXT ".lz")
set(ARCHIVE_ZST_EXT ".zst")


set(ARCHIVE_LIST_ALL_FORMATS ${ARCHIVE_TAR_GZ_EXT} ${ARCHIVE_TAR_BZ2_EXT} ${ARCHIVE_ZIP_EXT} ${ARCHIVE_TAR_XZ_EXT} ${ARCHIVE_ZST_EXT} ${ARCHIVE_SEVEN_Z_EXT} ${ARCHIVE_RAR_EXT} ${ARCHIVE_LZ_EXT})
set(ARCHIVE_LIST_LINUX_FORMATS ${ARCHIVE_TAR_GZ_EXT} ${ARCHIVE_TAR_BZ2_EXT} ${ARCHIVE_ZIP_EXT} ${ARCHIVE_TAR_XZ_EXT} ${ARCHIVE_ZST_EXT} ${ARCHIVE_SEVEN_Z_EXT} ${ARCHIVE_RAR_EXT})
set(ARCHIVE_LIST_WINDOWS_FORMATS ${ARCHIVE_ZIP_EXT} ${ARCHIVE_SEVEN_Z_EXT} ${ARCHIVE_RAR_EXT})
set(ARCHIVE_LIST_DARWIN_FORMATS ${ARCHIVE_TAR_GZ_EXT} ${ARCHIVE_TAR_BZ2_EXT} ${ARCHIVE_ZIP_EXT} ${ARCHIVE_TAR_XZ_EXT} ${ARCHIVE_ZST_EXT} ${ARCHIVE_SEVEN_Z_EXT})
set(ARCHIVE_LIST_BSD_FORMATS ${ARCHIVE_TAR_GZ_EXT} ${ARCHIVE_TAR_XZ_EXT} ${ARCHIVE_ZIP_EXT} ${ARCHIVE_LZ_EXT} ${ARCHIVE_SEVEN_Z_EXT})
