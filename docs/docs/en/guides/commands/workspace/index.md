---
title: Workspace
tags:
    - workspace
---
# Workspace

**Command**: `workspace`

**Shorthands**: `w`

The `workspace` command is a parent command that provides various operations for managing [Workspace][workspace_concept](s). This command supports subcommands like `list`, `describe`, and `remove` to handle different workspace-related tasks. Additionally, it includes the `--switch` flag to set the [`selected workspace`][selected_workspace_concept] among existing workspaces.

A workspace in `pars` is a structure that organizes projects, tasks, and workflows, providing physical isolation. Multiple workspaces can be defined, and references to these workspaces can be made where needed. For example, when adding a project, you can specify the workspace with the `--workspace` flag or argument: `pars project new test-project-name --workspace my-workspace`.

`pars` provides support for autocompletion, filtering, and suggestions using the tab key, making it easier to work with workspaces.


## Usage
``` {.sh linenums="0" .no-copy}
pars workspace [flags]
```
``` {.sh linenums="0" .no-copy}
pars workspace [command]
```



## Commands

| Name                          | Description |
|-------------------------------|-------------|
| [`list`][workspace_list_command]             | List Workspaces in <pars:Environment> |
| [`describe`][workspace_describe_command]     | Describe Workspace details |
| [`remove`][workspace_remove_command]         | Remove Workspace |



???+ tip
    You can use suggestions to list available sub commands. To do this, simply press ++tab++ to proceed. For more details, please visit our [Command Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/commands.md).
	



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



| Name          | Datatype    | Required  | Default             | Description |
|---------------|-------------|-----------|---------------------|-------------|
| `--switch`, `-s` | `string`    | true      | `workspace_name`    | Switch current workspace |


### `--switch`
* Aliases `-s`
* Datatype: `string`
* Type: `workspace`
* Multiplicity: Optional
* Description: Specifies the name of the workspace to set as selected.





**Usage**

* The `--switch` flag is used to set an existing workspace as the [`selected workspace`][selected_workspace_concept]. This flag allows you to quickly change the selected workspace without needing to perform multiple steps.

???+ tip
    You can use suggestions to list available workspaces. To do this, simply press ++tab++ to proceed. For more details, please visit our [Workspace Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/workspaces.md).

**Notes**

* Ensure the workspace name provided with the `--switch` flag exists to avoid errors during command execution.

??? example

    ```sh
    pars workspace --switch OmicronConsulting
    ```
    <div class="result" sh>
    Swithched to: OmicronConsulting
    </div>



<!-- Additional links -->
[workspace_concept]: ../../../getting-started/concept/workspace.md
[selected_workspace_concept]: ../../../getting-started/concept/workspace.md#selected-workspace
[workspace_list_command]: list.md
[workspace_describe_command]: describe.md
[workspace_remove_command]: remove.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags