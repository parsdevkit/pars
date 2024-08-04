---
title: Resource Remove
tags:
    - resource
    - remove
---

# Resource Remove

**Command**: `resource remove`

**Shorthands**: `r r`

The `resource remove` command is used to delete one or more specified [Resource][resource_concept] structures. Resources can be removed by providing one or more `name` arguments or using the `--file` flag to specify a configuration file with the resource names to delete. 




## Usage
``` {.sh linenums="0" .no-copy}
pars resource remove name [name] [flags]
```

``` {.sh linenums="0" .no-copy}
pars resource remove [flags]
```


    

## Arguments

| Name    | Datatype    | Required | Default | Description |
|---------|-------------|-----------|----------------|-------------|
| `name`  | `[]resource`   | true      | `""`           | Resource name |





### `name`
* Datatype: `[]resource`
* Type: `text`
* Multiplicity: Multiple
* Default: `none`
* Validation Rules: Existing Resource names
* Args Index: all
* Description: Names of the resources you want to remove. If provided, the `--file` flag will be ignored.


???+ tip
    You can use suggestions to list available resources. To do this, simply press ++tab++ to proceed. For more details, please visit our [Resource Autocompletion and Filtering Guide](../../advanced-usage/autocompletion-and-filtering/resources.md).


**Usage**

The name argument is used to specify one or more resource names that you want to remove. This is useful for quickly deleting a few resources without needing a configuration file.

**Notes**

* Multiple resource names can be provided as space-separated values.
* If the name argument is provided, the `--file` flag will be ignored even if it is specified.
* Ensure the resource names provided are valid and exist to avoid errors during command execution.



??? example


    **Removing single resource**
    ```sh
    pars resource remove ProductBrand_SeedData
    ```
    <div class="result" sh>
    Resource (ProductBrand_SeedData) deleted permanently
    </div>
    

    **Removing multiple resource**
    ```sh
    pars resource remove ProductBrand_SeedData Product_SeedData
    ```
    <div class="result" sh>
    <pre>
    Resource (ProductBrand_SeedData) deleted permanently
    Resource (Product_SeedData) deleted permanently
    </pre>
    </div>

## Flags


!!! quaoto ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]


| Name          | Datatype    | Required  | Default             | Description |
|---------------|-------------|-----------|---------------------|-------------|
| `--file`, `-f`   | `file`    | true      | `""`    | Remove resource(s) from manifest file |


### `--file`
* Aliases `-f`
* Datatype: `file`
* Type: `text`
* Schema: [ObjectResourceObjectModel], [DataResourceObjectModel]
* Multiplicity: Optional
* Description: Specify the path to a file containing resource names to remove. This will be ignored if any name arguments are provided.
* Valid Values: `current_folder`, `absoulute_path_to_folder`, `absoulute_path_to_file`, `relative_path_to_folder`, `relative_path_to_file`





!!! failure ""

    :bangbang: If the `name` argument is provided, the command will ignore the `--file` flag.



**Usage**

* The `--file` flag is used to specify a configuration file containing the names of the resources to be removed. The file should contain a list of resource names. This flag is useful for batch deletion of resources.

**Notes**

* Ensure that the file path provided with the `--file` flag is accessible and contains valid resource names to avoid errors during command execution.



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

    --8<-- "docs\en\samples\files\resource-models\001\readme.md"
    

    **Specify Current Directory**

    ``` sh
    pars resource remove --file .
    ```
    <div class="result" sh>
    <pre>
    Resource (ProductCategory_SeedData) deleted permanently
    Resource (ProductBrand_SeedData) deleted permanently
    Resource (Product_SeedData) deleted permanently
    </pre>
    </div>


    **Specify a Relative Directory**

    ``` sh
    pars resource remove --file ./samples/
    ```
    <div class="result" sh>
    <pre>
    Resource (ProductCategory_SeedData) deleted permanently
    Resource (ProductBrand_SeedData) deleted permanently
    Resource (Product_SeedData) deleted permanently
    </pre>
    </div>


    **Specify a Relative File**

    ``` sh
    pars resource remove --file ./samples/ProductCategorySeedDataResource.yaml
    ```
    <div class="result" sh>
    <pre>
    Resource (ProductCategory_SeedData) deleted permanently
    </pre>
    </div>


    **Specify an Absolute Directory**
    
    ``` sh
    pars resource remove --file C:/samples/
    ```
    <div class="result" sh>
    <pre>
    Resource (ProductCategory_SeedData) deleted permanently
    Resource (ProductBrand_SeedData) deleted permanently
    Resource (Product_SeedData) deleted permanently
    </pre>
    </div>

    **Specify an Absolute File**

    ``` sh
    pars resource remove --file C:/samples/ProductCategorySeedDataResource.yaml
    ```
    <div class="result" sh>
    <pre>
    Resource (ProductCategory_SeedData) deleted permanently
    </pre>
    </div>

    **Specify Multiple Files or Directories**

    ``` sh
    pars resource remove --file ./samples/ProductCategorySeedDataResource.yaml --file ./samples/ProductBrandSeedDataResource.yaml
    ```
    <div class="result" sh>
    <pre>
    Resource (ProductCategory_SeedData) deleted permanently
    Resource (ProductBrand_SeedData) deleted permanently
    </pre>
    </div>
    



<!-- Additional links -->
[resource_concept]: ../../../getting-started/concept/resource.md
[ObjectResourceObjectModel]: ../../schemas/object/resource/object-resource-object-model.md
[DataResourceObjectModel]: ../../schemas/object/resource/data-resource-object-model.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags