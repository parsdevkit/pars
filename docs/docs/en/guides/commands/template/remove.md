---
title: Template Remove
tags:
    - template
    - remove
---

# Template Remove

**Command**: `template remove`

**Shorthands**: `t r`

The `template remove` command is used to delete one or more specified [Template][template_concept] structures. Templates can be removed by providing one or more `name` arguments or using the `--file` flag to specify a configuration file with the template names to delete. 




## Usage
``` {.sh linenums="0" .no-copy}
pars template remove name [name] [flags]
```

``` {.sh linenums="0" .no-copy}
pars template remove [flags]
```


    

## Arguments

| Name    | Datatype    | Required | Default | Description |
|---------|-------------|-----------|----------------|-------------|
| `name`  | `[]template`   | true      | `""`           | Template name |





### `name`
* Datatype: `[]template`
* Type: `text`
* Multiplicity: Multiple
* Default: `none`
* Validation Rules: Existing Template names
* Args Index: all
* Description: Names of the templates you want to remove. If provided, the `--file` flag will be ignored.


???+ tip
    You can use suggestions to list available templates. To do this, simply press ++tab++ to proceed. For more details, please visit our [Template Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/templates.md).


**Usage**

The name argument is used to specify one or more template names that you want to remove. This is useful for quickly deleting a few templates without needing a configuration file.

**Notes**

* Multiple template names can be provided as space-separated values.
* If the name argument is provided, the `--file` flag will be ignored even if it is specified.
* Ensure the template names provided are valid and exist to avoid errors during command execution.



??? example


    **Removing single template**
    ```sh
    pars template remove SeedFileTxt_Template
    ```
    <div class="result" sh>
    Template (SeedFileTxt_Template) deleted permanently
    </div>
    

    **Removing multiple template**
    ```sh
    pars template remove SeedFileTxt_Template SeedFileYaml_Template
    ```
    <div class="result" sh>
    <pre>
    Template (SeedFileTxt_Template) deleted permanently
    Template (SeedFileYaml_Template) deleted permanently
    </pre>
    </div>

## Flags


!!! quaoto ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


| Name          | Datatype    | Required  | Default             | Description |
|---------------|-------------|-----------|---------------------|-------------|
| `--file`, `-f`   | `file`    | true      | `""`    | Remove template(s) from manifest file |


### `--file`
* Aliases `-f`
* Datatype: `file`
* Type: `text`
* Schema: [SharedTemplateObjectModel], [CodeTemplateObjectModel], [FileTemplateObjectModel]
* Multiplicity: Optional
* Description: Specify the path to a file containing template names to remove. This will be ignored if any name arguments are provided.
* Valid Values: `current_folder`, `absoulute_path_to_folder`, `absoulute_path_to_file`, `relative_path_to_folder`, `relative_path_to_file`





!!! failure ""

    :bangbang: If the `name` argument is provided, the command will ignore the `--file` flag.



**Usage**

* The `--file` flag is used to specify a configuration file containing the names of the templates to be removed. The file should contain a list of template names. This flag is useful for batch deletion of templates.

**Notes**

* Ensure that the file path provided with the `--file` flag is accessible and contains valid template names to avoid errors during command execution.



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

    --8<-- "docs\en\samples\files\template-models\001\readme.md"
    

    **Specify Current Directory**

    ``` sh
    pars template remove --file .
    ```
    <div class="result" sh>
    <pre>
    Template (SeedFileTxt_Template) deleted permanently
    Template (SeedFileYaml_Template) deleted permanently
    Template (OrionTech) deleted permanently
    </pre>
    </div>


    **Specify a Relative Directory**

    ``` sh
    pars template remove --file ./samples/
    ```
    <div class="result" sh>
    <pre>
    Template (SeedFileTxt_Template) deleted permanently
    Template (SeedFileYaml_Template) deleted permanently
    Template (OrionTech) deleted permanently
    </pre>
    </div>


    **Specify a Relative File**

    ``` sh
    pars template remove --file ./samples/SeedFileYamlTemplate.yaml
    ```
    <div class="result" sh>
    <pre>
    Template (SeedFileTxt_Template) deleted permanently
    </pre>
    </div>


    **Specify an Absolute Directory**
    
    ``` sh
    pars template remove --file C:/samples/
    ```
    <div class="result" sh>
    <pre>
    Template (SeedFileTxt_Template) deleted permanently
    Template (SeedFileYaml_Template) deleted permanently
    Template (OrionTech) deleted permanently
    </pre>
    </div>

    **Specify an Absolute File**

    ``` sh
    pars template remove --file C:/samples/SeedFileYamlTemplate.yaml
    ```
    <div class="result" sh>
    <pre>
    Template (SeedFileTxt_Template) deleted permanently
    </pre>
    </div>

    **Specify Multiple Files or Directories**

    ``` sh
    pars template remove --file ./samples/SeedFileYamlTemplate.yaml --file ./samples/SeedFileJsonTemplate.yaml
    ```
    <div class="result" sh>
    <pre>
    Template (SeedFileTxt_Template) deleted permanently
    Template (SeedFileYaml_Template) deleted permanently
    </pre>
    </div>
    



<!-- Additional links -->
[template_concept]: ../../../getting-started/concept/template.md
[SharedTemplateObjectModel]: ../../schemas/object/template/shared-template-object-model.md
[FileTemplateObjectModel]: ../../schemas/object/template/file-template-object-model.md
[CodeTemplateObjectModel]: ../../schemas/object/template/code-template-object-model.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags