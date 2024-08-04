---
title: Shared Template Object Model
---

# Shared Template Object Model


## Overview

**YAML Structure**

```yaml
Type: Template
Kind: Shared
Name: 
Metadata:
  Tags:
Specifications:
  Name: 
  Workspace: 
  Template:
    Content: |
      // Your template content goes here
```

**Summary**

* `Type`: Must always be `Template`.
* `Kind`: Should be `Shared`.
* `Name`: Unique identifier for the template.
* `Metadata`: Contains `Tags` for labeling and categorization.
* `Specifications`:
    * `Name`: Instance name used in development and generation.
    * `Workspace`: Specifies the workspace where the template is defined. Default is `None`.
    * `Template`: Defines the template.




**Fields**

* **Type**: `Template`
* **Kind**: `Shared`
* **Name**: [`String`][String]
* **Metadata**: [`Metadata`](#metadata)
* **Specifications**: [`Specifications`](#specifications)



**Required Fields**

* `Type`
* `Kind`
* `Name`
* `Specifications.Name`


## Field Descriptions

### `Type`

**Definition**

* DataType: [`String`][String]
* Type: `fixed-value`
* Multiplicity: Required
* Default: `none`
* Valid values: Must be `Template`
* Description: Specifies the type of the model.


**Usage**

The `Type` field identifies the model type as a Template.



**Notes**

* This field is mandatory and must always be set to `Template`.


**Example**

```yaml
Type: Template
```






### `Kind`

**Definition**

* DataType: [`String`][String]
* Type: `fixed-value`
* Multiplicity: Required
* Default: `none`
* Valid values: Must be `Shared`
* Description: Specifies the kind of the resource.

**Usage**

The `Kind` field identifies the resource type as an Shared.

**Notes**

* This field is mandatory and must always be set to `Shared`.

**Example**

```yaml
Kind: Shared
```






### `Name`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Valid values: Any string value that ensures uniqueness within the environment.
* Description: A unique identifier for the resource, assigned by the developer. This name should be unique within the selected environment.

**Usage**

The `Name` is used to identify the resource model and must align with the project architecture and plan.

**Notes**

* Ensure the `Name` is unique to avoid conflicts.

**Example**

```yaml
Name: UserResource
```







### `Metadata`

**Definition**

* DataType: `object`
* Type: `structured-data`
* Multiplicity: Optional
* Default: `none`
* Description: An object containing metadata about the resource.





### `Metadata.Tags`

**Definition**

* DataType: `[]string`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Labels for the resource, used for filtering, grouping, and selection purposes.

**Usage**

Use `Tags` to categorize and manage resources more effectively.

**Notes**

* `Tags` can be used for filtering and organizing resources based on specific criteria.



**Examples**

```yaml
Metadata:
  Tags:
  - catalog
  - category
```




### `Specifications`

**Definition**

* DataType: `object`
* Type: `structured-data`
* Multiplicity: Required
* Default: `none`
* Description: Contains specific details about the resource instance.





### `Specifications.Name`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: The name given to the resource instance. This is used during development or generation processes. While the name in the header identifies the model, the name in the specifications identifies the instance of the resource.

**Usage**

This `Name` is used to reference the specific instance of the resource.

**Notes**

* Different from the header `Name`, which identifies the model.

**Example**

```yaml
Specifications:
  Name: Categories
```








### `specifications.Set`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Optional
* Default: `none`
* Description: An optional field used to group resources, similar to projects.

**Usage**

Use `Set` to group related resources together.

**Notes**

* Useful for managing related resources in a microservices architecture or monolithic application.

**Example**

```yaml
Specifications:
  set: EShopping
```







### `specifications.Workspace`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Optional
* Default: `None`
* Description: Specifies the workspace where the template is defined.


**Usage**

The `Workspace` field identifies the workspace in which the template is defined.




**Notes**

* If not specified, the default value is None.

**Example**

```yaml
Specifications:
  Workspace: CommonWorkspace
```





### `specifications.Template.Content`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: Defines the code template. Can be multiline.


**Usage**

The `Content` field allows for the definition of a multiline code template. You can use [Shared Template Context][template_context]



**Notes**

* Used to define reusable code templates for common and standard operations.
* Can be imported and used in other templates.



**Example**

```yaml
Specifications:
  Template:
    Content: |
      // This is a shared template
      // Define your reusable code here
      function exampleFunction() {
        console.log("Hello, World!");
      }

```




## Examples

???+ example


    ```yaml
    Type: Template
    Kind: Shared
    Name: ResourceNameTemplate
    Metadata:
    Tags:
    Specifications:
      Name: ResourceNameTemplate
      Workspace: CommonWorkspace
      Template:
          Content: |
          // This is a shared template
          // Define your reusable code here
          function exampleFunction() {
              console.log("Hello, World!");
          }


    ```

---
This document provides detailed information about the `Data Resource` model used in Pars. The `Data Resource` model is defined with specific fields that help in structuring and managing different data resources. The `data` field allows for flexible and YAML-compliant data definitions.








<!-- Additional links -->

[template_context]: shared-template-context-object.md

[String]: ../../../references/value-types.md#string