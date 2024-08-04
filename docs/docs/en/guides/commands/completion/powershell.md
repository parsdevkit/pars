---
title: Completion Powershell
tags:
    - completion
    - powershell
---

# Completion Powershell

**Command**: `completion powershell`

**Shorthands**: 


The `pars completion powershell` command provides autocompletion support for the `pars` CLI in the Fish shell. This feature enhances the user experience by allowing easy navigation and selection of commands, flags, and arguments using the Tab key.



## Usage
``` {.powershell linenums="0" .no-copy}
pars completion powershell [flags]
```



??? example

    **Classic usage**
    ```powershell
    pars completion powershell
    ```
    <div class="result" powershell>
    \# powershell completion for pars                                 -*- shell-script -*-

    ...
    
    Register-ArgumentCompleter -CommandName 'pars' -ScriptBlock ${__parsCompleterBlock}
    </div>
    



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


## Installation

To load completions

=== "Windows"

    ```powershell
    pars completion powershell | Out-String | Invoke-Expression
    ```




---
This documentation provides a comprehensive overview of the `pars completion powershell` command, including installation instructions, usage examples, and details about global flags. By enabling autocompletion for Powershell, you can enhance your productivity and streamline your workflow with the `pars` CLI.



<!-- Additional links -->
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags