---
title: Completion Zsh
tags:
    - completion
    - zsh
---

# Completion Zsh

**Command**: `completion zsh`

**Shorthands**: 


The `pars completion zsh` command provides autocompletion support for the `pars` CLI in the Fish shell. This feature enhances the user experience by allowing easy navigation and selection of commands, flags, and arguments using the Tab key.



## Usage
``` {.zsh linenums="0" .no-copy}
pars completion zsh [flags]
```



??? example

    **Classic usage**
    ```zsh
    pars completion zsh
    ```
    <div class="result" zsh>
    <pre>
    \#compdef pars
    compdef _pars pars

    \# zsh completion for pars                                 -*- shell-script -*-

    ...

    \# don't run the completion function when being source-ed or eval-ed
    if [ "$funcstack[1]" = "_pars" ]; then
        _pars
    fi
    </pre>
    </div>
    



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


## Installation

To load completions

=== "Linux"

    ```zsh
    pars completion zsh > "${fpath[1]}/_pars"
    ```

=== "macOS"

    ```zsh
    pars completion zsh > $(brew --prefix)/share/zsh/site-functions/_pars
    ```





---
This documentation provides a comprehensive overview of the `pars completion zsh` command, including installation instructions, usage examples, and details about global flags. By enabling autocompletion for Zsh, you can enhance your productivity and streamline your workflow with the `pars` CLI.


<!-- Additional links -->
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags