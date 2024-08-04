---
title: Completion Bash
tags:
    - completion
    - bash
---

# Completion Bash

**Command**: `completion bash`

**Shorthands**: 


The `pars completion bash` command provides autocompletion support for the `pars` CLI in the Bash shell. This feature enhances the user experience by allowing easy navigation and selection of commands, flags, and arguments using the Tab key.



## Usage
``` {.sh linenums="0" .no-copy}
pars completion bash [flags]
```



??? example

    **Classic usage**
    ```sh
    pars completion bash
    ```
    <div class="result" sh>
    \# bash completion V2 for pars                                 -*- shell-script -*-

    ...
    
    \# ex: ts=4 sw=4 et filetype=sh
    </div>
    



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


## Installation

To load completions

=== "Linux"

    ```sh
    pars completion bash > /etc/bash_completion.d/pars
    ```


=== "macOS"

    ```sh
    pars completion bash > $(brew --prefix)/etc/bash_completion.d/pars
    ```


---
This documentation provides a comprehensive overview of the `pars completion bash` command, including installation instructions, usage examples, and details about global flags. By enabling autocompletion for Bash, you can enhance your productivity and streamline your workflow with the `pars` CLI.

<!-- Additional links -->
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags