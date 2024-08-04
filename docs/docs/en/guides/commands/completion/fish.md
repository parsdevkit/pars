---
title: Completion Fish
tags:
    - completion
    - fish
---

# Completion Fish

**Command**: `completion fish`

**Shorthands**: 


The `pars completion fish` command provides autocompletion support for the `pars` CLI in the Fish shell. This feature enhances the user experience by allowing easy navigation and selection of commands, flags, and arguments using the Tab key.


## Usage
``` {.fish linenums="0" .no-copy}
pars completion fish [flags]
```



??? example

    **Classic usage**
    ```fish
    pars completion fish
    ```
    <div class="result" fish>
    \# fish completion for pars                                 -*- shell-script -*-

    ...
    
    complete -k -c pars -n '__pars_requires_order_preservation && __pars_prepare_completions' -f -a '$__pars_comp_results
    </div>
    



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


## Installation

To load completions

=== "Linux"

    ```fish
    pars completion fish > ~/.config/fish/completions/pars.fish
    ```




---
This documentation provides a comprehensive overview of the `pars completion fish` command, including installation instructions, usage examples, and details about global flags. By enabling autocompletion for Fish, you can enhance your productivity and streamline your workflow with the `pars` CLI.


<!-- Additional links -->
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags