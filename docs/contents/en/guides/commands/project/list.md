---
title: Project List
tags:
    - project
    - list
---

# Project List

**Command**: `project list`

**Shorthands**: `p l`

The `project list` command is used to display a list of existing [Project][project_concept] structures. This command helps you view all the projects that have been created, along with their details.


## Usage
``` {.sh linenums="0" .no-copy}
pars project list [flags]
```



??? example

    **Classic usage**
    ```sh
    pars project list
    ```
    <div class="result" sh>
    <pre>
    (3) application project available
    </pre>
    <pre>
    \- AuthServiceProject (none-set)
    \- LogServiceProject (none-set)
    \- UserServiceProject (none-set)
    </pre>
    </div>
    



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



| Name          | Datatype    | Required  | Default             | Description |
|---------------|-------------|-----------|---------------------|-------------|
| `--workspace`, `-w` | `workspace` | false      | [`current_workspace`][current_workspace_concept]           | The name of the workspace whose projects you want to list


### `--workspace`
* Aliases `-w`
* Datatype: `workspace`
* Type: `text`
* Multiplicity: Optional
* Default: [`current_workspace`][current_workspace_concept]
* Validation Rules: Existing workspace names
* Description: List projects in the specified workspace



!!! note ""

    :bulb: If you don't specify workspace name, by default `pars` get [current workspace][current_workspace_concept] details


**Usage**

The `--workspace` flag is used to specify the workspace from which you want to list the projects. This flag helps you focus on the projects within a particular workspace managed by Pars.





**Notes**

* The `--workspace` flag is used in commands where you need to list projects within a specific workspace.
* Ensure that the workspace name provided is valid and recognized by Pars to avoid errors during the listing process.
* This flag is beneficial for scenarios where you need to review or manage projects within a particular workspace.





???+ tip
    You can use suggestions to list available workspaces. To do this, simply press ++tab++ to proceed. For more details, please visit our [Workspace Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/workspaces.md).


??? example

    ``` sh
    pars project list --workspace MyWorkspace
    ```
    <div class="result" sh>
    <pre>
    (3) application project available
    </pre>
    <pre>
    \- AuthServiceProject (none-set)
    \- LogServiceProject (none-set)
    \- UserServiceProject (none-set)
    </pre>
    </div>



<!-- Additional links -->
[project_concept]: ../../../getting-started/concept/project.md
[current_workspace_concept]: ../../../getting-started/concept/workspace.md#current-workspace
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags