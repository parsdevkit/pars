---
title: Project Describe
tags:
    - project
    - describe
---

# Project Describe

**Command**: `project describe`

**Shorthands**: `p d`


The `project describe` command is used to display detailed information about a specified [Project][project_concept] structure. This includes information such as the project details, path, package and any associated projects.


## Usage
``` {.sh linenums="0" .no-copy}
pars project describe [name] [flags]
```
    


## Arguments

| Name    | Datatype    | Required | Default | Description |
|---------|-------------|-----------|----------------|-------------|
| `name`  | `project`     | true      | `""`           | Project name |





### `name`
* Datatype: `project`
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Validation Rules: Existing project names
* Args Index: `0`
* Description: Project name


**Usage**

The `name` argument is used to specify the project name that you want to describe. This is required for the command to execute.

**Notes**

* Ensure the project name provided is valid and exists to avoid errors during command execution.

???+ tip
    You can use suggestions to list available projects. To do this, simply press ++tab++ to proceed. For more details, please visit our [Project Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/projects.md).




??? example


    ```sh
    pars project describe LogServiceProject
    ```
    <div class="result" sh>
    <pre>
    \- LogServiceProject (none-set)
             Labels: []
             Platform: Dotnet
             Type: Web Api
             Runtime: Unknown
             Layers: []
    </pre>
    </div>


## Flags


!!! quaoto ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



| Name          | Datatype    | Required  | Default             | Description |
|---------------|-------------|-----------|---------------------|-------------|
| `--workspace`, `-w` | `workspace` | false      | [`current_workspace`][current_workspace_concept]           | Name of the workspace where the project is located


### `--workspace`
* Aliases `-w`
* Datatype: `workspace`
* Type: `text`
* Multiplicity: Optional
* Default: [`current_workspace`][current_workspace_concept]
* Validation Rules: Existing workspace names
* Description: Describe project in the specified workspace



!!! note ""

    :bulb: If you don't specify workspace name, by default `pars` get [current workspace][current_workspace_concept] details


**Usage**

The `--workspace` flag is used to specify the workspace from which you want to describe project. This flag helps you focus on the projects within a particular workspace.





**Notes**

* The `--workspace` flag is used in commands where you need to describe project within a specific workspace.
* Ensure that the workspace name provided is valid and recognized by Pars to avoid errors during the describing process.
* This flag is beneficial for scenarios where you need to review or manage projects within a particular workspace.





???+ tip
    You can use suggestions to list available workspaces. To do this, simply press ++tab++ to proceed. For more details, please visit our [Workspace Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/workspaces.md).


??? example

    ```sh
    pars project describe --workspace MyWorkspace LogServiceProject
    ```
    <div class="result" sh>
    <pre>
    \- LogServiceProject (none-set)
             Labels: []
             Platform: Dotnet
             Type: Web Api
             Runtime: Unknown
             Layers: []
    </pre>
    </div>



<!-- Additional links -->
[project_concept]: ../../../getting-started/concept/project.md
[current_workspace_concept]: ../../../getting-started/concept/workspace.md#current-workspace
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags