---
title: Group Describe
tags:
    - group
    - describe
---

# Group Describe

**Command**: `group describe`

**Shorthands**: `g d`


The `group describe` command is used to display detailed information about a specified [Group][group_concept] structure. This includes information such as the group details, path, package and any associated projects.


## Usage
``` {.sh linenums="0" .no-copy}
pars group describe [name] [flags]
```
    


## Arguments

| Name    | Datatype    | Required | Default | Description |
|---------|-------------|-----------|----------------|-------------|
| `name`  | `group`     | true      | `""`           | Group name |





### `name`
* Datatype: `group`
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Validation Rules: Existing group names
* Args Index: `0`
* Description: Group name


**Usage**

The `name` argument is used to specify the group name that you want to describe. This is required for the command to execute.

**Notes**

* Ensure the group name provided is valid and exists to avoid errors during command execution.

???+ tip
    You can use suggestions to list available groups. To do this, simply press ++tab++ to proceed. For more details, please visit our [Group Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/groups.md).




??? example


    ```sh
    pars group describe ApexSolutions
    ```
    <div class="result" sh>
    <pre>
    Group Name:     ApexSolutions
    Path:           ApexSolutions
    Package:        ApexSolutions
    Projects:
      - UserAuthService
      - PaymentGatewayService
    </pre>
    </div>


## Flags


!!! quaoto ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


<!-- Additional links -->
[group_concept]: ../../../getting-started/concept/group.md
[project_concept]: ../../../getting-started/concept/project.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags