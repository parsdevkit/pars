function(include_all_components_from_directory)
    set(module_dir "${CMAKE_CURRENT_LIST_DIR}")

    get_filename_component(module_name ${module_dir} NAME)

    file(GLOB_RECURSE component_files "${module_dir}/components/*/component.cmake")

    foreach(component_file ${component_files})
        message(STATUS "Including component for module '${module_name}': ${component_file}")
        include(${component_file})
    endforeach()
endfunction()

