---
title: Application Project Object Model
---

# Application Project Object Model

## Overview

**YAML Structure**

```yaml
Type: Project
Kind: Application
Name:  
Metadata:
  Tags:
Specifications:
  Name: 
  Platform: 
    Type:
    Version:
  Runtime:
    Type:
    Version:
  Language:
    Type:
    Version:
  ProjectType:
  Set: 
  Group:
  Workspace:
  Package:
  Path:
  Labels:
  Configuration:
    Layers:
    - Name:
      Path:
      Package:
    Dependencies:
    - Name: 
      Version:
    References:
    - Name:
      Group:
      Workspace:
```

**Summary**

* `Type`: Must always be `Project`.
* `Kind`: Must always be `Application`.
* `Name`: Unique identifier for the project, applicable across different workspaces
* `Metadata`: Contains `Tags` for labeling and categorization. See the Metadata Section Documentation.
* `Specifications`:
    * `Name`: Instance name used in development and generation.
    * `Set`: Optional. Used to group projects, templates, resources, and tasks.
    * `Platform`: Indicates the technology or framework.
    * `Runtime`: Specifies the runtime environment.
    * `Language`: Specifies the programming language.
    * `ProjectType`: Type of the project.
    * `Package`: Defines the package or namespace.
    * `Group`: Indicates the group this project belongs to.
    * `Workspace`: Indicates the workspace this project belongs to.
    * `Path`: Relative path in the workspace.
    * `Labels`: Key-value pairs for filtering and selection.
    * `Configuration`: Contains layers, dependencies, and references.

This document serves as a guide for developers to correctly define and use the `Application Project` model in their YAML manifest files, ensuring proper structure and consistency in the workspace.

**Fields**

* **Type**: `Project`
* **Kind**: `Application`
* **Name**: [`String`][String]
* **Metadata**: [`Metadata`](#metadata)
* **Specifications**: [`Specifications`](#specifications)

**Required Fields**

* `Type`
* `Name`
* `Specifications.Name`
* `Specifications.Platform`
* `Specifications.ProjectType`


## Field Descriptions

### `Type`

**Definition**

* Datatype: [`String`][String]
* Type: `fixed-value`
* Multiplicity: Required
* Default: `none`
* Valid values: Must be `Project`
* Description: Specifies the type of the model.

**Usage**

The `Type` field identifies the model type as a Project.

**Notes**

* This field is mandatory and must always be set to `Project` and cannot be changed


**Examples**

```yaml
Type: Project
```


### `Kind`

**Definition**

* Datatype: [`String`][String]
* Type: `fixed-value`
* Multiplicity: Required
* Default: `none`
* Valid values: Must be `Application`
* Description: Specifies the kind of the project.

**Usage**

The `Kind` field identifies the project type as a Application.

**Notes**

* This field is mandatory and must always be set to `Application` and cannot be changed


**Examples**

```yaml
Kind: Project
```


### `Name`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Valid values: Any string value that ensures uniqueness within the workspace
* A unique identifier for the project, assigned by the developer. This name should be unique within the workspace, as the project is depend on the workspace.

**Usage**

The `Name` is used to identify the group model and must align with the project architecture and plan.

**Notes**

* Ensure the `Name` is unique to avoid conflicts in the workspace.


**Examples**

```yaml
Name: EShopping.ProductService
```

### `Metadata`

**Definition**

* Datatype: `object`
* Type: `structured-data`
* Multiplicity: Optional
* Default: `none`
* Description: An object containing metadata about the group


### `Metadata.Tags`

**Definition**

* Datatype: [`[]String`][String]
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Labels for the group, used for filtering, grouping, and selection purposes.

**Usage**

Use `Tags` to categorize and manage groups more effectively.

**Notes**

* `Tags` can be used for filtering and organizing groups based on specific criteria.



**Examples**

```yaml
Metadata:
  Tags:
  - backend
  - nodejs
```

```yaml
Metadata:
  Tags: [backend, nodejs]
```

### `Specifications`

**Definition**

* Datatype: `object`
* Type: `structured-data`
* Multiplicity: Required
* Default: `none`
* Description: Contains specific details about the project instance.


### `Specifications.Name`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Optional
* Default: `none`
* Description: The name given to the group instance. This is used during development or generation processes. While the `Name` in the header identifies the model, the `Name` in the specifications identifies the instance of the group.
* The name given to the project instance. This is used during development or generation processes. While the `Name` in the header identifies the model, the name in the specifications identifies the instance of the project.



**Usage**

This `Name` is used to reference the specific instance of the project.


**Notes**

* Different from the header `Name`, which identifies the model.


**Examples**

```yaml
Specifications:
  Name: ProductService
```










### `Specifications.Platform`

**Definition**

* Datatype: [`String`][String] or `object`
* Type: `text` or `structured-data`
* Multiplicity: Required
* Default: `none`,
* Valid values: `dotnet`, `go`, `nodejs`, `angular`, or specific versions.
* Description: Indicates the technology or framework used by the project.

!!! tip ""
    You can see all available platforms at [Platforms](../../../../extensions/platforms/index.md)

**Usage**

The `Platform` specifies the underlying technology stack for the project.


**Notes**

* You can set value as inline [`String`][String] or `platform object`



**Examples**

Inline latest version
```yaml
Specifications:
  Platform: nodejs
```

Inline specific version
```yaml
Specifications:
  Platform: nodejs@14
```

Object format
```yaml
Specifications:
  Platform: 
    Type: nodejs
    Version: 14
```






### `Specifications.Runtime`

**Definition**

* Datatype: [`String`][String] or `object`
* Type: `text` or `structured-data`
* Multiplicity: Required
* Default: `none`,
* Valid values: `dotnet`, `go`, `nodejs`, `angular`, or specific versions.
* Description: Specifies the runtime environment.



**Usage**

Defines the `Runtime` environment for the project.


**Notes**

* You can set value as inline [`String`][String] or `runtime object`



**Examples**

Inline latest version
```yaml
Specifications:
  Runtime: nodejs
```

Inline specific version
```yaml
Specifications:
  Runtime: nodejs@14
```

Object format
```yaml
Specifications:
  Runtime: 
    Type: nodejs
    Version: 14
```







### `Specifications.Language`

**Definition**

* Datatype: [`String`][String] or `object`
* Type: `text` or `structured-data`
* Multiplicity: Required
* Default: `none`,
* Valid values: `csharp`, `go`, `typescript`, `javascript`, or specific versions.
* Description: Specifies the programming language.



**Usage**

Defines the programming `Language` used in the project.


**Notes**

* You can set value as inline [`String`][String] or `language object`



**Examples**

Inline latest version
```yaml
Specifications:
  Runtime: javascript
```

Inline specific version
```yaml
Specifications:
  Runtime: javascript@es6
```

Object format
```yaml
Specifications:
  Runtime: 
    Type: javascript
    Version: es6
```


### `Specifications.ProjectType` 

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`,
* Valid values: `webapi`, `webapp`, `spa`, `console`, `library`, `desktop`, `mobile`.
* Description: Indicates the type of project.



**Usage**

Defines the project type within the given platform.


**Notes**

* Refer to the platform guide for supported project types



**Examples**

```yaml
Specifications:
  ProjectType: webapi
```




### `Specifications.Package`

**Definition**

* Datatype: [`String`][String] or `[]string`
* Type: `text` or `list`
* Multiplicity: Optional
* Default: Uses `Name` if not provided
* Description: Defines the package or namespace.




**Usage**

Specifies the package to organize code and resources under a specific namespace.


**Notes**

* If no `Package` is defined, the project `Name` is used as the default package name. 
* You can specify string split by `/`



**Examples**

```yaml
Specifications:
    Package: com/eshopping/product
```

```yaml
Specifications:
    Package:  [com, eshopping, product]
```

```yaml
Specifications:
    Package: 
    - com
    - eshopping
    - product
```





### `Specifications.Set`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Optional
* Default: `none`
* Description: An optional field used to group projects, templates, resources, and tasks for better organization.




**Usage**

Use `Set` to group related projects together.


**Notes**

* Useful for managing related projects in a microservices architecture or monolithic application.



**Examples**

```yaml
Specifications:
  Set: EShopping
```



### `Specifications.Group`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Optional
* Default: `none`
* Description: Indicates the group this project belongs to. Must be a previously defined group in Pars.





**Usage**

Specifies the `group` to which the project belongs, useful for organizing projects within the same group.


**Notes**

* If a `group` is defined, the project will be created within the group's directory, and the project's package will be defined within the group's package.




**Examples**

```yaml
Specifications:
    Group: EShopping
```



### `Specifications.Workspace`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Optional
* Default: Uses [`current workspace`][workspace_concept_current_workspace] if not provided
* Description: Specifies the workspace to which the project belongs.



**Usage**

Defines the workspace for the project. If the workspace is defined, the project will belong to the specified workspace. If not defined, the project will default to the current workspace.



**Notes**

* This value must be a workspace defined in Pars.
* Ensures that the project is correctly associated with the intended workspace.





**Examples**

```yaml
Specifications:
  Workspace: main
```




### `Specifications.Path`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Optional
* Default: Uses `Name` if not provided
* Description: Defines the relative path of the project within the workspace or group if defined.
* Valid values: Any valid relative path.



**Usage**

Specifies the path where the project will be created within the workspace or group if defined.



**Notes**

* If no `Path` is defined, the project name is used as the default path.




**Examples**

```yaml
Specifications:
  Path: services/product-service
```



### `Specifications.Labels`

**Definition**

* Datatype: [`Map[String, String]`][String]
* Type: `map`
* Multiplicity: Optional
* Default: `none`
* Description: Key-value pairs for filtering and selection.




**Usage**

Specifies labels to manage and organize projects based on key-value pairs.



**Notes**

* Labels can be used for filtering and selection in future decision-making processes.




**Examples**

```yaml
Specifications:
  Labels: 
  - environment: production
  - client: nodejs
```




### `Specifications.Configuration`

**Definition**

* Datatype: `object`
* Type: `structured-data`
* Multiplicity: Optional
* Default: `none`
* Description: Contains configuration details for the project







### `Specifications.Configuration.Layers`

**Definition**

* Datatype: `[]object`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Defines the directory and package structure of the project.


**Usage**

Specifies layers to organize the project's directory and package structure.


**Notes**

* Each layer can have its own path and package information.
* Best practice for the `Name` field is to use "`:`" to separate layers. This creates a hierarchical directory structure where each "`:`" denotes a subdirectory.
* The `Path` and `Package` information can be defined independently of the `Name` separator.



**Examples**

Inline example:

```yaml
Specifications:
  Configuration: 
    Layers:
    - Library:Data
```

Object example:

```yaml
Specifications:
  Configuration: 
    Layers:
    - Name: Library:Data
    Path: entities
    Package: entities
```








### `Specifications.Configuration.Dependencies`

**Definition**

* Datatype: `[]object`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Defines the dependencies for the project.


**Usage**

Specifies dependencies for the project.


**Notes**

* Dependencies can be defined inline or as objects with name and version.


**Examples**

Inline example:

```yaml
Specifications:
  Configuration: 
    Dependencies:
    - express
    - mongoose@5.10.9
```

Object example:

```yaml
Specifications:
  Configuration: 
    Layers:
    - Name: mongoose
    Version: 5.10.9
```








### `Specifications.Configuration.References`

**Definition**

* Datatype: `[]object`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Defines references to other projects.


**Usage**

Specifies references to other projects within the same or different groups.


**Notes**

* References include project name, group, and workspace.


**Examples**

```yaml
Specifications:
  Configuration: 
    References:
    - Name: EShopping.Core
    Group: EShopping
    Workspace: main
```


## Examples

???+ example


    ```yaml
    ---
    Type: Project
    Kind: Application
    Name: NodeShop.ProductService
    Metadata:
        Tags: [backend, nodejs]
    Specifications:
        Name: ProductService
        Set: NodeShop
        Platform:
            Type: NodeJS
            Version: 14
        Runtime:
            Type: NodeJS
            Version: 14
        Language:
            Type: javascript
            Version: es6
        ProjectType: webapi
        Package: com.nodeshop.product
        Group: NodeShopGroup
        Path: /services/product-service
        Labels:
            environment: production
            client: nodejs
        Configuration:
            Layers:
            - Name: Library:Data:Entities
              Path: entities
              Package: entities
            Dependencies:
            - Name: express
            - Name: mongoose
              Version: 5.10.9
              References:
            - Name: NodeShop.Core
            Group: NodeShopGroup
            Workspace: main
    ```



!!! tip ""
    You can visit [Application Project Samples](../../../../extras/samples/application-project/index.md) for different examples.


---
This document provides detailed information about the `Application Project` project model used in Pars for dynamic code generation. The `Application Project` project model is defined with specific fields and sections that help in structuring and managing different projects.


<!-- Additional links -->
[workspace_concept]: ../../../../getting-started/concept/workspace.md
[workspace_concept_current_workspace]: ../../../../getting-started/concept/workspace.md#current-workspace

[String]: ../../../references/value-types.md#string