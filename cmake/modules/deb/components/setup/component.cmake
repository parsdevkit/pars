set(PACKAGES
    build-essential
    devscripts
    dh-make
    debhelper
    lintian
    fakeroot
    cmake
)

add_custom_target(build.deb.package.setup
    COMMAND ${CMAKE_COMMAND} -E echo "Setting up the host machine for package build..."
    
    COMMAND sudo apt-get update && sudo apt-get install -y ${PACKAGES}

    DEPENDS check_env_for_deb_packing
)