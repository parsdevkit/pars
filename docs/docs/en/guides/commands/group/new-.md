---
title: Group Submit
tags:
    - group
    - submit
---

# Group Submit

**Command**: `group submit`

**Shorthands**: `g s`


The `group submit` command is used to create a new [Group][group_concept] structure(s). The group can be created by providing a `name` argument or using the `--file` flag to specify the path to a configuration file.



## Usage
``` {.sh linenums="0" .no-copy}
pars group submit [name] [flags]
```

``` {.sh linenums="0" .no-copy}
pars group submit [flags]
```



## Arguments

| Name    | Datatype    | Required | Default | Description |
|---------|-------------|-----------|----------------|-------------|
| `name`  | `string`    | false     | `""`           | Group name |





### `name`
* Datatype: `string`
* Type: `text`
* Multiplicity: Optional
* Default: `none`
* Validation Rules: Avoid Non-English charachters
* Args Index: `0`
* Description: New group name



??? example

    ```sh
    pars group submit ApexSolutions
    ```
    <div class="result" sh>
    ApexSolutions Group created
    </div>



## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



| Name          | Datatype    | Required  | Default             | Description |
|---------------|-------------|-----------|---------------------|-------------|
| `--file`, `-f`   | `file`    | true      | `""`    | Create group(s) from manifest file |


### `--file`
* Aliases `-f`
* Datatype: `file`
* Type: `text`
* Schema: [GroupObjectModel]
* Multiplicity: Optional
* Description: New group manifest file location
* Valid Values: `current_folder`, `absoulute_path_to_folder`, `absoulute_path_to_file`, `relative_path_to_folder`, `relative_path_to_file`

!!! failure ""

    :bangbang: When both `name` argument and `--file` flag are provided, the command will prioritize the `name` argument for group creation.



**Usage**

The `--file` flag is used to specify the path to directories or files. It supports various forms of paths including current directory (.), relative paths, absolute paths, and specific files. This flag can be used one or more times within a command.



**Notes**

* The `--file` flag can be repeated multiple times to specify multiple paths.
* Ensure that the paths provided with the `--file` flag are accessible and the configuration file is valid to avoid errors during command execution.
* The `--file` flag can be used to automate the creation of groups with predefined configurations.



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
    pars group submit --file .
    ```
    <div class="result" sh>
    <pre>
    ApexSolutions Group created
    NeptuneDev Group created
    OrionTech Group created
    </pre>
    </div>


    **Specify a Relative Directory**

    ``` sh
    pars group submit --file ./samples/
    ```
    <div class="result" sh>
    <pre>
    ApexSolutions Group created
    NeptuneDev Group created
    OrionTech Group created
    </pre>
    </div>


    **Specify a Relative File**

    ``` sh
    pars group submit --file ./samples/ApexSolutions.yaml
    ```
    <div class="result" sh>
    <pre>
    ApexSolutions Group created
    </pre>
    </div>


    **Specify an Absolute Directory**
    
    ``` sh
    pars group submit --file C:/samples/
    ```
    <div class="result" sh>
    <pre>
    ApexSolutions Group created
    NeptuneDev Group created
    OrionTech Group created
    </pre>
    </div>

    **Specify an Absolute File**

    ``` sh
    pars group submit --file C:/samples/ApexSolutions.yaml
    ```
    <div class="result" sh>
    <pre>
    ApexSolutions Group created
    </pre>
    </div>

    **Specify Multiple Files or Directories**

    ``` sh
    pars group submit --file ./samples/ApexSolutions.yaml --file ./samples/NeptuneDev.yaml
    ```
    <div class="result" sh>
    <pre>
    ApexSolutions Group created
    NeptuneDev Group created
    </pre>
    </div>


<!-- 
## Validation and Error Handling


## Summary -->



<!-- Additional links -->
[group_concept]: ../../../getting-started/concept/group.md
[GroupObjectModel]: ../../schemas/object/group/group-object-model.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags