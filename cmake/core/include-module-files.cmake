function(include_module_files)
    set(module_dir "${CMAKE_CURRENT_LIST_DIR}")

    get_filename_component(module_name ${module_dir} NAME)

    set(consts_file "${module_dir}/Consts.cmake")
    if(EXISTS ${consts_file})
        message(STATUS "Including consts file for module '${module_name}': ${consts_file}")
        include(${consts_file})
    endif()

    set(functions_file "${module_dir}/Functions.cmake")
    if(EXISTS ${functions_file})
        message(STATUS "Including functions file for module '${module_name}': ${functions_file}")
        include(${functions_file})
    endif()

    set(module_file "${module_dir}/Module.cmake")
    if(EXISTS ${module_file})
        message(STATUS "Including main module file for module '${module_name}': ${module_file}")
        include(${module_file})
    else()
        message(FATAL_ERROR "Error: ${module_file} not found. Every module must have a Module.cmake file.")
    endif()
endfunction()

