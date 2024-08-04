---
title: Code Template Object Model
---

# Code Template Object Model


## Overview

**YAML Structure**

```yaml
Type: Template
Kind: Code
Name: 
Metadata:
  Tags:
Specifications:
  Name: 
  Output:
  Set: 
  Layers:
    - Name:
      Sections:
        - Classes:
  Workspace: None
  Template:
    Code: |
      // Your code template goes here

```

**Summary**

* `Type`: Must always be `Template`.
* `Kind`: Should be `Code`.
* `Name`: Unique identifier for the template.
* `Metadata`: Contains `Tags` for labeling and categorization.
* `Specifications`:
    * `Name`: Instance name used in development and generation.
    * `Output`: Specifies the output file name, can be dynamically set (e.g., `{{Resource.Name}}.ts`).
    * `Set`: Similar to resource model set, indicates which project group it belongs to.
    * `Layers`: Specifies which layers it applies to.
    * `Sections`: Specifies which sections it applies to, with filtering using classes.
    * `Workspace`: Specifies the workspace where the template is defined. Default is `None`.
    * `Template.Code`: Defines the code template. Can be multiline.



**Fields**

* **Type**: `Template`
* **Kind**: `Code`
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
* Default: `Template`
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
* Default: `Code`
* Valid values: Must be `Code`
* Description: Specifies the kind of the template.


**Usage**

The `Kind` field identifies the resource type as an Code.

**Notes**

* This field is mandatory and must always be set to `Code`.

**Example**

```yaml
Kind: Code
```






### `Name`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Valid values: Any string value that ensures uniqueness within the environment.
* Description: A unique identifier for the template, assigned by the developer. This name should be unique within the selected environment.

**Usage**

The `Name` is used to identify the template and must align with the project architecture and plan.

**Notes**

* Ensure the `Name` is unique to avoid conflicts.

**Example**

```yaml
Name: DtoTemplate
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
  - dto
  - template
```




### `Specifications`

**Definition**

* DataType: `object`
* Type: `structured-data`
* Multiplicity: Required
* Default: `none`
* Description: Contains specific details about the template  instance.





### `Specifications.Name`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: The name given to the template instance. This is used during development or generation processes.

**Usage**

This `Name` is used to reference the specific instance of the template.

**Notes**

* Different from the header `Name`, which identifies the model.

**Example**

```yaml
Specifications:
  Name: ResponseDto
```








### `Specifications.Set`

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
  Set: EShopping
```







### `Specifications.Output`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: Specifies the output file name. Can be dynamically set using templates.



**Usage**

The `Output` field specifies the name of the output file. It can use dynamic values from the resource using template syntax.



**Notes**

* Used to define reusable code templates for common and standard operations.
* Can be imported and used in other templates.



**Example**

```yaml
Specifications:
  Output: '{{.Resource.Name}}Dto.ts'


```



### `Specifications.Workspace`

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







### `Specifications.Layers`

**Definition**

* DataType: `array`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Defines layers where only the name is specified.

**Usage**

Specifies layers to organize the resource's structure.


**Notes**

* Similar to the layers in projects, but only the name is specified without path and package information.

**Example**

```yaml
Specifications:
  Layers:
  - Name: Controllers
  - Name: Services
```




### `Specifications.Layers.Sections`

**Definition**

* DataType: `array`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Specifies which sections the template applies to, with filtering using classes.



**Usage**

The `Sections` field specifies which sections the template should be applied to. It can filter within sections using classes.




**Example**

```yaml
Specifications:
  Layers:
    - Name: Controllers
      Sections:
        - Classes:
          - ResponseDto
```




### `Specifications.Template.Code`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: Defines the code template. Can be multiline.


**Usage**

The `Code` field allows for the definition of a multiline code template.



**Notes**

* Used to define reusable code templates for common and standard operations.
* Can be imported and used in other templates.



**Example**

```yaml
Specifications:
  Template:
    Code: |
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
    Kind: Code
    Name: ResponseDto
    Metadata:
    Tags:
    Specifications:
      Name: ResponseDto
      Output: '{{template "ResourceNameTemplate" .}}.cs'
      Set: EShopping
      Layers:
      - Name: Dtos
        Sections:
          - Classes:
            - ResponseDto
      Template:
          Code: |
          // This is a code template for ResponseDto
          public class {{.name}} {
              public string Name { get; set; }
              public string Description { get; set; }
          }

    ```

---
This document provides detailed information about the `Data Resource` model used in Pars. The `Data Resource` model is defined with specific fields that help in structuring and managing different data resources. The `data` field allows for flexible and YAML-compliant data definitions.








<!-- Additional links -->

[String]: ../../../references/value-types.md#string