---
title: Template List
tags:
    - template
    - list
---

# Template List

**Command**: `template list`

**Shorthands**: `t l`

The `template list` command is used to display a list of existing [Template][template_concept] structures. This command helps you view all the templates that have been created, along with their details.


## Usage
``` {.sh linenums="0" .no-copy}
pars template list [flags]
```



??? example

    **Classic usage**
    ```sh
    pars template list
    ```
    <div class="result" sh>
    <pre>
    (2) template available
    *** Global Templates ***

    (0) shared template available


    \--------------------------

    (0) code template available


    \--------------------------

    (0) file template available


    *** Workspace Specific Templates ***

    (0) shared template available


    \--------------------------

    (0) code template available


    \--------------------------

    (2) file template available

    - SeedFileJson_Template (EShopping)
    - SeedFileYaml_Template (EShopping)
    </pre>
    </div>
    



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



<!-- Additional links -->
[template_concept]: ../../../getting-started/concept/template.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags