---
title: Project Submit
tags:
    - project
    - submit
---

# Project Submit

**Command**: `project submit`

**Shorthands**: `p s`


The `project submit` command is used to create a new [Project][project_concept] structure(s). The project can be created by providing  `--file` flag to specify the path to a configuration file.



## Usage
``` {.sh linenums="0" .no-copy}
pars project submit [flags]
```



## Arguments





## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



| Name          | Datatype    | Required  | Default             | Description |
|---------------|-------------|-----------|---------------------|-------------|
| `--file`, `-f`   | `file`    | true      | `""`    | Create project(s) from manifest file |
| `--no-init`      | `boolean` | true      | `false`    | Create project(s) declaration only  |
| `--workspace`, `-w` | `workspace` | false      | [`current_workspace`][current_workspace_concept]           | Name of the workspace where the project is located



### `--file`
* Aliases `-f`
* Datatype: `file`
* Type: `text`
* Schema: [ApplicationProjectObjectModel]
* Multiplicity: Optional
* Description: New project manifest file location
* Valid Values: `current_folder`, `absoulute_path_to_folder`, `absoulute_path_to_file`, `relative_path_to_folder`, `relative_path_to_file`



**Usage**

The `--file` flag is used to specify the path to directories or files. It supports various forms of paths including current directory (.), relative paths, absolute paths, and specific files. This flag can be used one or more times within a command.



**Notes**

* The `--file` flag can be repeated multiple times to specify multiple paths.
* Ensure that the paths provided with the `--file` flag are accessible and the configuration file is valid to avoid errors during command execution.
* The `--file` flag can be used to automate the creation of projects with predefined configurations.



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
    pars project submit --file .
    ```
    <div class="result" sh>
    <pre>
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\AuthService\AuthService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\AuthService\AuthService.csproj (in 1.51 sec).
    Restore succeeded.


    AuthServiceProject (0) Project created
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\LogService\LogService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\LogService\LogService.csproj (in 239 ms).
    Restore succeeded.


    LogServiceProject (1) Project created
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\UserService\UserService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\UserService\UserService.csproj (in 225 ms).
    Restore succeeded.


    UserServiceProject (2) Project created
    </pre>
    </div>


    **Specify a Relative Directory**

    ``` sh
    pars project submit --file ./samples/
    ```
    <div class="result" sh>
    <pre>
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\AuthService\AuthService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\AuthService\AuthService.csproj (in 1.51 sec).
    Restore succeeded.


    AuthServiceProject (0) Project created
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\LogService\LogService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\LogService\LogService.csproj (in 239 ms).
    Restore succeeded.


    LogServiceProject (1) Project created
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\UserService\UserService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\UserService\UserService.csproj (in 225 ms).
    Restore succeeded.


    UserServiceProject (2) Project created
    </pre>
    </div>


    **Specify a Relative File**

    ``` sh
    pars project submit --file ./samples/AuthServiceWebApi.yaml
    ```
    <div class="result" sh>
    <pre>
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\AuthService\AuthService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\AuthService\AuthService.csproj (in 1.51 sec).
    Restore succeeded.


    AuthServiceProject (0) Project created
    </pre>
    </div>


    **Specify an Absolute Directory**
    
    ``` sh
    pars project submit --file C:/samples/
    ```
    <div class="result" sh>
    <pre>
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\AuthService\AuthService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\AuthService\AuthService.csproj (in 1.51 sec).
    Restore succeeded.


    AuthServiceProject (0) Project created
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\LogService\LogService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\LogService\LogService.csproj (in 239 ms).
    Restore succeeded.


    LogServiceProject (1) Project created
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\UserService\UserService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\UserService\UserService.csproj (in 225 ms).
    Restore succeeded.


    UserServiceProject (2) Project created
    </pre>
    </div>

    **Specify an Absolute File**

    ``` sh
    pars project submit --file C:/samples/AuthServiceWebApi.yaml
    ```
    <div class="result" sh>
    <pre>
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\AuthService\AuthService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\AuthService\AuthService.csproj (in 1.51 sec).
    Restore succeeded.


    AuthServiceProject (0) Project created
    </pre>
    </div>

    **Specify Multiple Files or Directories**

    ``` sh
    pars project submit --file ./samples/AuthServiceWebApi.yaml --file ./samples/LogServiceWebApi.yaml
    ```
    <div class="result" sh>
    <pre>
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\AuthService\AuthService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\AuthService\AuthService.csproj (in 1.51 sec).
    Restore succeeded.


    AuthServiceProject (0) Project created
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\workspace\codebase\LogService\LogService.csproj:
    Determining projects to restore...
    Restored C:\workspace\codebase\LogService\LogService.csproj (in 239 ms).
    Restore succeeded.


    LogServiceProject (1) Project created
    </pre>
    </div>



### `--no-init`
* Datatype: `boolean`
* Type: `boolean`
* Multiplicity: Optional
* Default: `false`
* Description: Register existing project manifests without physically creating new projects
* Valid Values: `true`, `false`



**Usage**

The `--no-init` flag is used to indicate that the specified project models should only be registered with the parser and not physically created. This flag is useful when you have predefined project configurations that you want to make known to the parser without initiating the creation process.





**Notes**

* The `--no-init` flag can be used in commands where you need to register existing projects.
* Ensure that the project models provided are valid and accessible to avoid errors during the registration process.
* This flag is beneficial for scenarios where project configurations already exist and you want to reintroduce them to the parser for further operations without creating new projects.






??? example

    ``` sh
    pars project submit --file C:/samples/AuthServiceWebApi.yaml
    ```
    <div class="result" sh>
    <pre>
    AuthServiceProject (0) Project created
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

The `--workspace` flag is used to specify the workspace from which you want to create projects. This flag helps you focus on the projects within a particular workspace.





**Notes**

* The `--workspace` flag is used in commands where you need to create projects within a specific workspace.
* Ensure that the workspace name provided is valid and recognized by Pars to avoid errors during the creation process.
* This flag is beneficial for scenarios where you need to review or manage projects within a particular workspace.





???+ tip
    You can use suggestions to list available workspaces. To do this, simply press ++tab++ to proceed. For more details, please visit our [Workspace Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/workspaces.md).


??? example

    ``` sh
    pars project submit --file ./samples/AuthServiceWebApi.yaml --workspace MyWorkspace
    ```
    <div class="result" sh>
    <pre>
    The template "ASP.NET Core Web API" was created successfully.

    Processing post-creation actions...
    Restoring C:\MyWorkspace\codebase\AuthService\AuthService.csproj:
    Determining projects to restore...
    Restored C:\MyWorkspace\codebase\AuthService\AuthService.csproj (in 1.51 sec).
    Restore succeeded.


    AuthServiceProject (0) Project created
    </pre>
    </div>
    </div>

<!-- 
## Validation and Error Handling


## Summary -->



<!-- Additional links -->
[project_concept]: ../../../getting-started/concept/project.md
[current_workspace_concept]: ../../../getting-started/concept/workspace.md#current-workspace
[ApplicationProjectObjectModel]: ../../schemas/object/project/application-project-object-model.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags