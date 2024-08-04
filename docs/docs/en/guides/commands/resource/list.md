---
title: Resource List
tags:
    - resource
    - list
---

# Resource List

**Command**: `resource list`

**Shorthands**: `r l`

The `resource list` command is used to display a list of existing [Resource][resource_concept] structures. This command helps you view all the resources that have been created, along with their details. You can find all [Global Resources][global_resource_concept], [Workspace Resources][workspace_resource_concept], [Object Resources][object_resource_concept], [Data Resources][data_resource_concept]


## Usage
``` {.sh linenums="0" .no-copy}
pars resource list [flags]
```



??? example

    **Classic usage**
    ```sh
    pars resource list
    ```
    <div class="result" sh>
    <pre>
    *** Global Resources ***

    (0) object resource available


    \--------------------------

    (0) data resource available


    *** Workspace Specific Resources ***

    (0) object resource available


    \--------------------------

    (2) data resource available

    - Product_SeedData (EShopping)
    - ProductBrand_SeedData (EShopping)
    </pre>
    </div>
    



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



<!-- Additional links -->
[resource_concept]: ../../../getting-started/concept/resource.md
[global_resource_concept]: ../../../getting-started/concept/resource.md#global-resources
[workspace_resource_concept]: ../../../getting-started/concept/resource.md#workspace-resources
[object_resource_concept]: ../../../getting-started/concept/resource.md#object-resources
[data_resource_concept]: ../../../getting-started/concept/resource.md#data-resources
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags