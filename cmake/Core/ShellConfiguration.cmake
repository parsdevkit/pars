set(SHELL "" CACHE STRING "Custom shell to be used (e.g. bash, zsh, fish, powershell, cmd)")

function(get_shell detected_shell)
    if(SHELL)
        message(STATUS "Using custom shell: ${SHELL}")
        set(${detected_shell} ${SHELL} PARENT_SCOPE)
    else()
        if(WIN32)
            # Check for PowerShell Core (pwsh) first
            execute_process(
                COMMAND pwsh -Command "echo 'pwsh detected'"
                RESULT_VARIABLE PW_SH_DETECTED
                OUTPUT_QUIET ERROR_QUIET
            )

            if(PW_SH_DETECTED EQUAL 0)
                message(STATUS "Detected PowerShell Core (pwsh)")
                set(${detected_shell} "pwsh" PARENT_SCOPE)
            else()
                # Check for regular PowerShell (powershell)
                execute_process(
                    COMMAND powershell -Command "echo 'powershell detected'"
                    RESULT_VARIABLE PS_DETECTED
                    OUTPUT_QUIET ERROR_QUIET
                )

                if(PS_DETECTED EQUAL 0)
                    message(STATUS "Detected Windows PowerShell")
                    set(${detected_shell} "powershell" PARENT_SCOPE)
                else()
                    # If neither PowerShell Core nor regular PowerShell is found, fallback to cmd
                    message(WARNING "Neither PowerShell Core (pwsh) nor PowerShell found. Defaulting to cmd.")
                    set(${detected_shell} "cmd" PARENT_SCOPE)
                endif()
            endif()
        else()
            # For Unix-like systems, use a fallback method to determine the shell
            execute_process(
                COMMAND bash -c "echo \$SHELL"
                OUTPUT_VARIABLE DEFAULT_SHELL
                OUTPUT_STRIP_TRAILING_WHITESPACE
            )

            if (NOT DEFAULT_SHELL)
                message(WARNING "Could not detect shell. Using bash as default.")
                set(${detected_shell} "bash" PARENT_SCOPE)
            else()
                message(STATUS "Detected default shell: ${DEFAULT_SHELL}")

                if("${DEFAULT_SHELL}" MATCHES "bash")
                    set(${detected_shell} "bash" PARENT_SCOPE)
                elseif("${DEFAULT_SHELL}" MATCHES "zsh")
                    set(${detected_shell} "zsh" PARENT_SCOPE)
                elseif("${DEFAULT_SHELL}" MATCHES "fish")
                    set(${detected_shell} "fish" PARENT_SCOPE)
                else()
                    message(WARNING "Unknown shell detected: ${DEFAULT_SHELL}, using bash as fallback.")
                    set(${detected_shell} "bash" PARENT_SCOPE)
                endif()
            endif()
        endif()
    endif()
endfunction()
get_shell(HOST_SHELL)