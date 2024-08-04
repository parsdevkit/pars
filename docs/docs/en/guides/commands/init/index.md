---
title: Init
tags:
    - init
---
# Init

**Command**: `init`

**Shorthands**: `i`

The `init` command is used to create a new workspace. This is the only way to create a workspace in the application. It accepts `name` and `path` arguments. If


!!! tip ""

    If you are creating a workspace for the first time, it will be marked as the [`selected workspace`][workspace_concept_selected_workspace].



## Usage
``` {.sh linenums="0" .no-copy}
pars init [name] [path] [flags]
```


??? example
    ```sh
    pars init
    ```
    <div class="result" sh>
    New workspace (workspace) created at: C:\foo\current_directory\workspace
    </div>



## Arguments

| Name    | Datatype    | Required | Default | Description |
|---------|-------------|-----------|-----------------------|-------------|
| `name`  | `string`    | false     | `workspace`           | Name of the workspace |
| `path`  | `directory`    | false     | `current directory`     | Path where the workspace will be created |





### `name`
* Datatype: `string`
* Type: `text`
* Multiplicity: Optional
* Default: `workspace`
* Validation Rules: Avoid Non-English charachters
* Args Index: `0`
* Description: The name of the workspace. If not specified, it defaults to workspace.

**Usage**

The `name` argument is used to specify the name of the workspace to be created. If not provided, the default name workspace will be used.

**Notes**

* Ensure the workspace name is valid to avoid errors during command execution.


??? example

    **Default name** : 
        Workspace `name` will be created by adding increasing numbers to the end  '*`workspace` + `[0-9]?`*'

    ```sh
    pars init
    ```
    <div class="result" sh>
    New workspace (workspace) created at: C:\foo\current_directory\workspace
    </div>

    **Custom name** : 
        Workspace `name` will be set to specified name  '*ws_name*'

    ```sh
    pars init ws_name
    ```
    <div class="result" sh>
    New workspace (ws_name) created at: C:\foo\current_directory\ws_name
    </div>


### `path`
* Datatype: `string`
* Type: `path` (Absolute, Relative path)
* Multiplicity: Optional
* Default: `current directory` + `workspace name`
* Valid Values: ` `, `.`, `Relative Path`, `Absolute Path`
* Args Index: `1`
* Description: The directory path where the workspace will be created. If not specified, the current directory will be used, and a folder with the workspace name will be created. If . is specified, the current directory itself will be used as the workspace path.


**Usage**

The `path` argument is used to specify the location where the workspace will be created. This can be an absolute or relative path.

**Notes**

* If the path does not exist, it will be created.
* If not specified, the current directory will be used, and a folder with the workspace name will be created.
* If `.` is specified, the current directory will be used directly as the workspace path.

???+ tip
    You can use suggestions to list available paths. To do this, simply press ++tab++ to proceed. For more details, please visit our [Path Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/paths.md).


??? example

    **Non-path** : 
        Workspace `path` will be generated automatically like '*`current directory` + `workspace name`*'

    ```sh
    pars init ws_name
    ```
    <div class="result" sh>
    New workspace (ws_name) created at: C:\foo\current_directory\ws_name
    </div>







    **Current Directory** : 
        Workspace `path` will be generated automatically like '*`current directory`*'

    ```sh
    pars init ws_name .
    ```
    <div class="result" sh>
    New workspace (ws_name) created at: C:\foo\current_directory
    </div>






    **Relative Path** : 
        Workspace `path` will be generated automatically like '*`current directory` + `custom_dir`*'

    ```sh
    pars init ws_name /custom_dir
    ```
    <div class="result" sh>
    New workspace (ws_name) created at: C:\foo\current_directory\custom_dir
    </div>







    **Absoulute Path** : 
        Workspace `path` will be use given path '*`C:/custom_dir`*'

    ```sh
    pars init ws_name C:/custom_dir
    ```
    <div class="result" sh>
    New workspace (ws_name) created at: C:/custom_dir
    </div>







## Flags

!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



<!-- Additional links -->
[workspace_concept]: ../../../getting-started/concept/workspace.md
[workspace_concept_selected_workspace]: ../../../getting-started/concept/workspace.md#selected-workspace
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags