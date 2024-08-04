---
title: Workspace Describe
tags:
    - workspace
    - describe
---

# Workspace Describe

**Command**: `workspace describe`

**Shorthands**: `w d`

The `workspace describe` command is used to display detailed information about a specified [Workspace][workspace_concept]. This includes information such as the workspace's path, associated projects, and their structure. The command supports additional flags to customize the output.



## Usage
``` {.sh linenums="0" .no-copy}
pars workspace describe [name] [flags]
```


??? example

    ```sh
    pars workspace describe OmicronConsulting
    ```
    <div class="result" sh>
    <pre>
    Workspace (OmicronConsulting) has 2 project
    Path : C:\current_directory\OmicronConsulting

    Projects:
    ApexSolutions
    - UserAuthService ()
    - PaymentGatewayService ()    
    </pre>
    </div>
    


## Arguments

| Name    | Datatype    | Required | Default | Description |
|---------|-------------|-----------|-----------------------|-------------|
| `name`  | `workspace`    | false     | [`current_workspace`][current_workspace_concept]           | The name of the workspace you want to describe |





### `name`
* Datatype: `workspace`
* Type: `text`
* Multiplicity: Optional
* Default: [`current_workspace`][current_workspace_concept]
* Validation Rules: Existing workspace names
* Args Index: `0`
* Description: Workspace name



!!! note ""

    :bulb: If you don't specify workspace name, by default `pars` get [current workspace][current_workspace_concept] details


**Usage**

The `name` argument is used to specify the workspace name that you want to describe. This is required for the command to execute.

**Notes**

* Ensure the workspace name provided is valid and exists to avoid errors during command execution.


???+ tip
    You can use suggestions to list available workspaces. To do this, simply press ++tab++ to proceed. For more details, please visit our [Workspace Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/workspaces.md).
	



??? example


    **Current workspace** : 
        Get details for [current workspace][current_workspace_concept]


    ```sh
    pars workspace describe
    ```
    <div class="result" sh>
    <pre>
    Workspace (OmicronConsulting) has 2 project
    Path : C:\current_directory\OmicronConsulting

    Projects:
    ApexSolutions
    - UserAuthService ()
    - PaymentGatewayService ()
    </pre>
    </div>
    



    **Specific workspace** : 
        Get details for custom workspace


    ```sh
    pars workspace describe EpsilonEnterprises
    ```
    <div class="result" sh>
    <pre>
    Workspace (EpsilonEnterprises) has 0 project
    Path : C:\current_directory\EpsilonEnterprises

    Projects:
    ApexSolutions
    - UserAuthService ()
    - PaymentGatewayService ()
    </pre>
    </div>

## Flags


!!! quaoto ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



| Name          | Datatype    | Required | Default | Description |
|---------------|-------------|-----------|-----------------------|-------------|
| `--path`, `-p`   | `boolean`   | false     | `false`                | Show only the path of the workspace |
| `--view`, `-v`   | [`WorkspaceViewTypesEnum`][workspaceviewtypesenum]  | false     | `Hierarchical`     | Specify the view format (e.g., hierarchical, flat) |


### `--path`
* Aliases `-p`
* Datatype: `boolean`
* Type: `boolean`
* Multiplicity: Optional
* Default: `false`
* Description: Show only the path of the workspace.



???+ question "Use Cases"

    * Change working directory

    === "Powershell"

        ```powershell
        cd (pars workspace describe --path)
        ```
        <div class="result" powershell>
        </div>

    === "Bash"

        ```sh
        pars workspace describe --path | cd
        ```
        <div class="result" sh>
        </div>


    * Open working directory in VS Code

    === "Powershell"

        ```powershell
        code (pars workspace describe --path)
        ```
        <div class="result" powershell>
        </div>

    === "Bash"

        ```sh
        pars workspace describe --path | code
        ```
        <div class="result" sh>
        </div>


**Usage**

The `--path` flag is used to display only the path of the specified workspace. No additional information will be shown.

**Notes**

* This flag does not require a value; simply setting the flag will trigger this behavior.

??? example

    ```sh
    pars workspace OmicronConsulting --path
    ```
    <div class="result" sh>
    C:\foo\current_directory\OmicronConsulting
    </div>

!!! failure ""

    :bangbang: `path` flag should be used alone, if you set this flag, you will get only path


    ```sh
    pars workspace describe --path --view flat
    ```
    <div class="result" sh>
    C:\foo\current_directory\OmicronConsulting
    </div>


### `--view`
* Datatype: [`WorkspaceViewTypesEnum`][workspaceviewtypesenum]
* Type: `enum`
* Multiplicity: Optional
* Default: `Hierarchical`
* Valid Values: `Hierarchical`, `Flat`
* Description: Specify the view format for the projects within the workspace


???+ tip
    You can use suggestions to list available view types. To do this, simply press ++tab++ to proceed. For more details, please visit our [Enumeration Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/enumerations.md).

**Usage**

The `--view` flag is used to specify how the projects within the workspace should be displayed. The default format is flat, but it can be set to hierarchical to show a nested structure.

**Notes**

* Ensure the specified format is supported to avoid errors during command execution.

??? example

    **Hierarchical View** : 
        List workspace projects in tree view

    ```sh
    pars workspace describe --view Hierarchical
    ```
    <div class="result" sh>
    <pre>
    Workspace (OmicronConsulting) has 2 project
    Path : C:\current_directory\OmicronConsulting

    Projects:
    ApexSolutions
    - UserAuthService ()
    - PaymentGatewayService ()
    </pre>
    </div>


    **Flat View** : 
        List workspace projects in basic list

    ```sh
    pars workspace describe --view Flat
    ```
    <div class="result" sh>
    <pre>
    Workspace (OmicronConsulting) has 2 project
    Path : C:\current_directory\OmicronConsulting

    Projects:
    ApexSolutions
    - UserAuthService ()
    - PaymentGatewayService ()
    </pre>
    </div>


<!-- Additional links -->
[workspace_concept]: ../../../getting-started/concept/workspace.md
[current_workspace_concept]: ../../../getting-started/concept/workspace.md#current-workspace
[project_concept]: ../../../getting-started/concept/project.md
[workspaceviewtypesenum]: ../../schemas/enum/workspaceViewTypesEnum.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags