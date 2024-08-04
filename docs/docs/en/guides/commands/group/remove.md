---
title: Group Remove
tags:
    - group
    - remove
---

# Group Remove

**Command**: `group remove`

**Shorthands**: `g r`

The `group remove` command is used to delete one or more specified [Group][group_concept] structures. Groups can be removed by providing one or more `name` arguments or using the `--file` flag to specify a configuration file with the group names to delete. 




## Usage
``` {.sh linenums="0" .no-copy}
pars group remove name [name] [flags]
```

``` {.sh linenums="0" .no-copy}
pars group remove [flags]
```


    

## Arguments

| Name    | Datatype    | Required | Default | Description |
|---------|-------------|-----------|----------------|-------------|
| `name`  | `[]group`   | true      | `""`           | Group name |





### `name`
* Datatype: `[]group`
* Type: `text`
* Multiplicity: Multiple
* Default: `none`
* Validation Rules: Existing Group names
* Args Index: all
* Description: Names of the groups you want to remove. If provided, the `--file` flag will be ignored.


???+ tip
    You can use suggestions to list available groups. To do this, simply press ++tab++ to proceed. For more details, please visit our [Group Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/groups.md).


**Usage**

The name argument is used to specify one or more group names that you want to remove. This is useful for quickly deleting a few groups without needing a configuration file.

**Notes**

* Multiple group names can be provided as space-separated values.
* If the name argument is provided, the `--file` flag will be ignored even if it is specified.
* Ensure the group names provided are valid and exist to avoid errors during command execution.



??? example


    **Removing single group**
    ```sh
    pars group remove ApexSolutions
    ```
    <div class="result" sh>
    Group (ApexSolutions) deleted permanently
    </div>
    

    **Removing multiple group**
    ```sh
    pars group remove ApexSolutions NeptuneDev
    ```
    <div class="result" sh>
    <pre>
    Group (ApexSolutions) deleted permanently
    Group (NeptuneDev) deleted permanently
    </pre>
    </div>

## Flags


!!! quaoto ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


| Name          | Datatype    | Required  | Default             | Description |
|---------------|-------------|-----------|---------------------|-------------|
| `--file`, `-f`   | `file`    | true      | `""`    | Remove group(s) from manifest file |


### `--file`
* Aliases `-f`
* Datatype: `file`
* Type: `text`
* Schema: [GroupObjectHeaderModel]
* Multiplicity: Optional
* Description: Specify the path to a file containing group names to remove. This will be ignored if any name arguments are provided.
* Valid Values: `current_folder`, `absoulute_path_to_folder`, `absoulute_path_to_file`, `relative_path_to_folder`, `relative_path_to_file`





!!! failure ""

    :bangbang: If the `name` argument is provided, the command will ignore the `--file` flag.



**Usage**

* The `--file` flag is used to specify a configuration file containing the names of the groups to be removed. The file should contain a list of group names. This flag is useful for batch deletion of groups.

**Notes**

* Ensure that the file path provided with the `--file` flag is accessible and contains valid group names to avoid errors during command execution.



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

    --8<-- "docs\en\samples\files\group-models\001\readme.md"
    

    **Specify Current Directory**

    ``` sh
    pars group remove --file .
    ```
    <div class="result" sh>
    <pre>
    Group (ApexSolutions) deleted permanently
    Group (NeptuneDev) deleted permanently
    Group (OrionTech) deleted permanently
    </pre>
    </div>


    **Specify a Relative Directory**

    ``` sh
    pars group remove --file ./samples/
    ```
    <div class="result" sh>
    <pre>
    Group (ApexSolutions) deleted permanently
    Group (NeptuneDev) deleted permanently
    Group (OrionTech) deleted permanently
    </pre>
    </div>


    **Specify a Relative File**

    ``` sh
    pars group remove --file ./samples/ApexSolutions.yaml
    ```
    <div class="result" sh>
    <pre>
    Group (ApexSolutions) deleted permanently
    </pre>
    </div>


    **Specify an Absolute Directory**
    
    ``` sh
    pars group remove --file C:/samples/
    ```
    <div class="result" sh>
    <pre>
    Group (ApexSolutions) deleted permanently
    Group (NeptuneDev) deleted permanently
    Group (OrionTech) deleted permanently
    </pre>
    </div>

    **Specify an Absolute File**

    ``` sh
    pars group remove --file C:/samples/ApexSolutions.yaml
    ```
    <div class="result" sh>
    <pre>
    Group (ApexSolutions) deleted permanently
    </pre>
    </div>

    **Specify Multiple Files or Directories**

    ``` sh
    pars group remove --file ./samples/ApexSolutions.yaml --file ./samples/NeptuneDev.yaml
    ```
    <div class="result" sh>
    <pre>
    Group (ApexSolutions) deleted permanently
    Group (NeptuneDev) deleted permanently
    </pre>
    </div>
    



<!-- Additional links -->
[group_concept]: ../../../getting-started/concept/group.md
[GroupObjectHeaderModel]: ../../schemas/object/group/group-object-header-model.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags