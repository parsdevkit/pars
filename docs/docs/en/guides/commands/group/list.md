---
title: Group List
tags:
    - group
    - list
---

# Group List

**Command**: `group list`

**Shorthands**: `g l`

The `group list` command is used to display a list of existing [Group][group_concept] structures. This command helps you view all the groups that have been created, along with their details.


## Usage
``` {.sh linenums="0" .no-copy}
pars group list [flags]
```



??? example

    **Classic usage**
    ```sh
    pars group list
    ```
    <div class="result" sh>
    <pre>
    (2) group available
    ApexSolutions
    NeptuneDev
    </pre>
    </div>
    



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



<!-- Additional links -->
[group_concept]: ../../../getting-started/concept/group.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags