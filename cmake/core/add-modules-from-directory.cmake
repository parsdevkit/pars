function(add_modules_from_directory)
    file(GLOB directories RELATIVE ${CMAKE_CURRENT_LIST_DIR} ${CMAKE_CURRENT_LIST_DIR}/*)

    foreach(directory ${directories})
        if(IS_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/${directory})
            message(STATUS "Loading module: ${directory}")
            add_module(${CMAKE_CURRENT_LIST_DIR}/${directory})
        endif()
    endforeach()
endfunction()