---
title: Workspace Remove
tags:
    - workspace
    - remove
---

# Workspace Remove

**Command**: `workspace remove`

**Shorthands**: `w r`


The `workspace remove` command is used to delete one or more specified workspaces. This command helps you manage your workspaces by allowing the removal of unused or obsolete ones. Workspaces can be removed by providing one or more `name` arguments.




## Usage
``` {.sh linenums="0" .no-copy}
pars workspace remove name [name] [flags]
```


??? example

    ```sh
    pars workspace remove OmicronConsulting
    ```
    <div class="result" sh>
    Workspace (OmicronConsulting) deleted permanently
    </div>
    
    

    

## Arguments

| Name    | Datatype    | Required | Default | Description |
|---------|-------------|-----------|----------------|-------------|
| `name`  | `[]workspace` | true      | `""`           | Names of the workspaces to remove |





### `name`
* Datatype: `[]workspace`
* Type: `text`
* Multiplicity: Multiple values allowed
* Default: `none`
* Validation Rules: Existing workspace names
* Args Index: all
* Description: Names of the workspaces you want to remove. You can specify one or more workspace names separated by spaces



**Usage**

The `name` argument is used to specify one or more workspace names that you want to remove. This is useful for quickly deleting a few workspaces without needing a configuration file.

**Notes**

* Multiple workspace names can be provided as space-separated values.
* Ensure the workspace names provided are valid and exist to avoid errors during command execution.


???+ tip
    You can use suggestions to list available workspaces. To do this, simply press ++tab++ to proceed. For more details, please visit our [Workspace Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/workspaces.md).
	



??? example


    **Removing single workspace**
    ```sh
    pars workspace remove OmicronConsulting
    ```
    <div class="result" sh>
    Workspace (OmicronConsulting) deleted permanently
    </div>
    

    **Removing multiple workspace**
    ```sh
    pars workspace remove OmicronConsulting EpsilonEnterprises ZetaSystems
    ```
    <div class="result" sh>
    <pre>
    Workspace (OmicronConsulting) deleted permanently
    Workspace (EpsilonEnterprises) deleted permanently
    Workspace (ZetaSystems) deleted permanently
    </pre>
    </div>

## Flags


!!! quaoto ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


<!-- Additional links -->
[workspace_concept]: ../../../getting-started/concept/workspace.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags