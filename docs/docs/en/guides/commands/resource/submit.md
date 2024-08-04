---
title: Resource Submit
tags:
    - resource
    - submit
---

# Resource Submit

**Command**: `resource submit`

**Shorthands**: `r s`


The `resource submit` command is used to create a new [Resource][resource_concept] structure(s). The resource can be created by providing  `--file` flag to specify the path to a configuration file.



## Usage

``` {.sh linenums="0" .no-copy}
pars resource submit [flags]
```



## Arguments


## Flags


!!! abstract ""

    :pushpin: See [Global flags][globalflags] and [Common flags][commonflags]



| Name          | Datatype    | Required  | Default             | Description |
|---------------|-------------|-----------|---------------------|-------------|
| `--file`, `-f`   | `file`    | true      | `""`    | Create resource(s) from manifest file |


### `--file`
* Aliases `-f`
* Datatype: `file`
* Type: `text`
* Schema: [ObjectResourceObjectModel], [DataResourceObjectModel]
* Multiplicity: Optional
* Description: New resource manifest file location
* Valid Values: `current_folder`, `absoulute_path_to_folder`, `absoulute_path_to_file`, `relative_path_to_folder`, `relative_path_to_file`


**Usage**

The `--file` flag is used to specify the path to directories or files. It supports various forms of paths including current directory (.), relative paths, absolute paths, and specific files. This flag can be used one or more times within a command.



**Notes**

* The `--file` flag can be repeated multiple times to specify multiple paths.
* Ensure that the paths provided with the `--file` flag are accessible and the configuration file is valid to avoid errors during command execution.
* The `--file` flag can be used to automate the creation of resources with predefined configurations.



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
    pars resource submit --file .
    ```
    <div class="result" sh>
    <pre>
    ProductCategory_SeedData Resource created
    ProductBrand_SeedData Resource created
    Product_SeedData Resource created
    </pre>
    </div>


    **Specify a Relative Directory**

    ``` sh
    pars resource submit --file ./samples/
    ```
    <div class="result" sh>
    <pre>
    ProductCategory_SeedData Resource created
    ProductBrand_SeedData Resource created
    Product_SeedData Resource created
    </pre>
    </div>


    **Specify a Relative File**

    ``` sh
    pars resource submit --file ./samples/ProductCategorySeedDataResource.yaml
    ```
    <div class="result" sh>
    <pre>
    ProductCategory_SeedData Resource created
    </pre>
    </div>


    **Specify an Absolute Directory**
    
    ``` sh
    pars resource submit --file C:/samples/
    ```
    <div class="result" sh>
    <pre>
    ProductCategory_SeedData Resource created
    ProductBrand_SeedData Resource created
    Product_SeedData Resource created
    </pre>
    </div>

    **Specify an Absolute File**

    ``` sh
    pars resource submit --file C:/samples/ProductCategorySeedDataResource.yaml
    ```
    <div class="result" sh>
    <pre>
    ProductCategory_SeedData Resource created
    </pre>
    </div>

    **Specify Multiple Files or Directories**

    ``` sh
    pars resource submit --file ./samples/ProductCategorySeedDataResource.yaml --file ./samples/ProductBrandSeedDataResource.yaml
    ```
    <div class="result" sh>
    <pre>
    ProductCategory_SeedData Resource created
    ProductBrand_SeedData Resource created
    </pre>
    </div>


<!-- 
## Validation and Error Handling


## Summary -->



<!-- Additional links -->
[resource_concept]: ../../../getting-started/concept/resource.md
[ObjectResourceObjectModel]: ../../schemas/object/resource/object-resource-object-model.md
[DataResourceObjectModel]: ../../schemas/object/resource/data-resource-object-model.md
[globalflags]: ../index.md#global-flags
[commonflags]: ../index.md#common-flags