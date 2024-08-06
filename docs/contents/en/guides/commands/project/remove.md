---
title: Project Remove
tags:
    - project
    - remove
---

# Project Remove

**Command**: `project remove`

**Shorthands**: `p r`

The `project remove` command is used to delete one or more specified [Project][project_concept] structures. Projects can be removed by providing one or more `name` arguments or using the `--file` flag to specify a configuration file with the project names to delete. 




## Usage
``` {.sh linenums="0" .no-copy}
pars project remove name [name] [flags]
```

``` {.sh linenums="0" .no-copy}
pars project remove [flags]
```


    

## Arguments

| Name    | Datatype    | Required | Default | Description |
|---------|-------------|-----------|----------------|-------------|
| `name`  | `[]project`   | true      | `""`           | Project name |





### `name`
* Datatype: `[]project`
* Type: `text`
* Multiplicity: Multiple
* Default: `none`
* Validation Rules: Existing Project names
* Args Index: all
* Description: Names of the projects you want to remove. If provided, the `--file` flag will be ignored.


???+ tip
    You can use suggestions to list available projects. To do this, simply press ++tab++ to proceed. For more details, please visit our [Project Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/projects.md).


**Usage**

The name argument is used to specify one or more project names that you want to remove. This is useful for quickly deleting a few projects without needing a configuration file.

**Notes**

* Multiple project names can be provided as space-separated values.
* If the name argument is provided, the `--file` flag will be ignored even if it is specified.
* Ensure the project names provided are valid and exist to avoid errors during command execution.



??? example


    **Removing single project**
    ```sh
    pars pars project remove AuthServiceProject
    ```
    <div class="result" sh>
    Project (AuthService) deleted permanently
    </div>
    

    **Removing multiple project**
    ```sh
    pars project remove AuthService UserServiceProject
    ```
    <div class="result" sh>
    <pre>
    Project (AuthService) deleted permanently
    Project (UserServiceProject) deleted permanently
    </pre>
    </div>

## Flags


!!! quaoto ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


| Name          | Datatype    | Required  | Default             | Description |
|---------------|-------------|-----------|---------------------|-------------|
| `--file`, `-f`   | `file`    | true      | `""`    | Remove project(s) from manifest file |
| `--workspace`, `-w` | `workspace` | false      | [`current_workspace`][current_workspace_concept]           | Name of the workspace where the project is located


### `--file`
* Aliases `-f`
* Datatype: `file`
* Type: `text`
* Schema: [ProjectObjectHeaderModel]
* Multiplicity: Optional
* Description: Specify the path to a file containing project names to remove. This will be ignored if any name arguments are provided.
* Valid Values: `current_folder`, `absoulute_path_to_folder`, `absoulute_path_to_file`, `relative_path_to_folder`, `relative_path_to_file`





!!! failure ""

    :bangbang: If the `name` argument is provided, the command will ignore the `--file` flag.



**Usage**

* The `--file` flag is used to specify a configuration file containing the names of the projects to be removed. The file should contain a list of project names. This flag is useful for batch deletion of projects.

**Notes**

* Ensure that the file path provided with the `--file` flag is accessible and contains valid project names to avoid errors during command execution.



**Supported Path Formats**

* **Current Directory (`.`):**
Specifies the current working directory from which the command is being executed. This is useful for operations that need to be performed in the current directory without specifying the full path.

* **Relative Directory or File:**
Specifies a path relative to the current working directory. This allows for flexibility in specifying paths without needing the full directory structure.

* **Absolute Directory or File:**
Specifies the full path to a directory or file, starting from the root of the filesystem. This is useful when the exact location of the file or directory is known.



???+ tip
    You can use suggestions to list available paths. To do this, simply press ++tab++ to proceed. For more details, please visit our [Path Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/paths.md).



??? example

    --8<-- "docs\en\samples\files\project-models\001\readme.md"
    

    **Specify Current Directory**

    ``` sh
    pars project remove --file .
    ```
    <div class="result" sh>
    <pre>
    Project (AuthServiceProject) deleted permanently
    Project (UserServiceProject) deleted permanently
    Project (LogServiceProject) deleted permanently
    </pre>
    </div>


    **Specify a Relative Directory**

    ``` sh
    pars project remove --file ./samples/
    ```
    <div class="result" sh>
    <pre>
    Project (AuthServiceProject) deleted permanently
    Project (UserServiceProject) deleted permanently
    Project (LogServiceProject) deleted permanently
    </pre>
    </div>


    **Specify a Relative File**

    ``` sh
    pars project remove --file ./samples/AuthServiceProject.yaml
    ```
    <div class="result" sh>
    <pre>
    Project (AuthServiceProject) deleted permanently
    </pre>
    </div>


    **Specify an Absolute Directory**
    
    ``` sh
    pars project remove --file C:/samples/
    ```
    <div class="result" sh>
    <pre>
    Project (AuthServiceProject) deleted permanently
    Project (UserServiceProject) deleted permanently
    Project (LogServiceProject) deleted permanently
    </pre>
    </div>

    **Specify an Absolute File**

    ``` sh
    pars project remove --file C:/samples/AuthServiceProject.yaml
    ```
    <div class="result" sh>
    <pre>
    Project (AuthServiceProject) deleted permanently
    </pre>
    </div>

    **Specify Multiple Files or Directories**

    ``` sh
    pars project remove --file ./samples/AuthServiceProject.yaml --file ./samples/UserServiceProject.yaml
    ```
    <div class="result" sh>
    <pre>
    Project (AuthServiceProject) deleted permanently
    Project (UserServiceProject) deleted permanently
    </pre>
    </div>
    



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

The `--workspace` flag is used to specify the workspace from which you want to remove projects. This flag helps you focus on the projects within a particular workspace.





**Notes**

* The `--workspace` flag is used in commands where you need to remove projects within a specific workspace.
* Ensure that the workspace name provided is valid and recognized by Pars to avoid errors during the removing process.
* This flag is beneficial for scenarios where you need to review or manage projects within a particular workspace.





???+ tip
    You can use suggestions to list available workspaces. To do this, simply press ++tab++ to proceed. For more details, please visit our [Workspace Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/workspaces.md).
	


??? example

    --8<-- "docs\en\samples\files\project-models\001\readme.md"
    

    **Specify Current Directory**

    ``` sh
    pars project remove --workspace MyWorkspace AuthServiceProject
    ```
    <div class="result" sh>
    <pre>
    Project (AuthServiceProject) deleted permanently
    </pre>
    </div>



<!-- Additional links -->
[project_concept]: ../../../getting-started/concept/project.md
[current_workspace_concept]: ../../../getting-started/concept/workspace.md#current-workspace
[ProjectObjectHeaderModel]: ../../schemas/object/project/project-object-header-model.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags