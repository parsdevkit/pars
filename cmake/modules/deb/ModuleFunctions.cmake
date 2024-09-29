set(DEB_ARCH_X86 "i386")
set(DEB_ARCH_X86_64 "amd64")
set(DEB_ARCH_ARM "armhf")
set(DEB_ARCH_ARM64 "arm64")



function(map_arch_to_debarch input_arch output_debarch)
    if(${input_arch} STREQUAL ${ARCH_X86})
        set(${output_debarch} ${DEB_ARCH_X86} PARENT_SCOPE)
    elseif(${input_arch} STREQUAL ${ARCH_X86_64})
        set(${output_debarch} ${DEB_ARCH_X86_64} PARENT_SCOPE)
    elseif(${input_arch} STREQUAL ${ARCH_ARM})
        set(${output_debarch} ${DEB_ARCH_ARM} PARENT_SCOPE)
    elseif(${input_arch} STREQUAL ${ARCH_ARM64})
        set(${output_debarch} ${DEB_ARCH_ARM64} PARENT_SCOPE)
    else()
        message(FATAL_ERROR "Unsupported architecture: ${input_arch}")
    endif()
endfunction()

function(map_debarch_to_arch input_debarch output_arch)
    if(${input_debarch} STREQUAL ${DEB_ARCH_X86})
        set(${output_arch} ${ARCH_X86} PARENT_SCOPE)
    elseif(${input_debarch} STREQUAL ${DEB_ARCH_X86_64})
        set(${output_arch} ${ARCH_X86_64} PARENT_SCOPE)
    elseif(${input_debarch} STREQUAL ${DEB_ARCH_ARM})
        set(${output_arch} ${ARCH_ARM} PARENT_SCOPE)
    elseif(${input_debarch} STREQUAL ${DEB_ARCH_ARM64})
        set(${output_arch} ${ARCH_ARM64} PARENT_SCOPE)
    else()
        message(FATAL_ERROR "Unsupported Debian architecture: ${input_debarch}")
    endif()
endfunction()

execute_process(
    COMMAND bash -c "date -d '${RELEASE_DATE}' '+%a, %d %b %Y 00:00:00 +0000'"
    OUTPUT_VARIABLE RELEASE_DATE_DEB
    OUTPUT_STRIP_TRAILING_WHITESPACE
)