---
title: Data Resource Object Model
---

# Data Resource Object Model


## Overview

**YAML Structure**

```yaml
Type: Resource
Kind: Data
Name:  
MetaData:
Specifications:
  Name: 
  Set: 
  Layers: 
  - Name:
    Sections:
      - Name:
        Classes:
        Attributes:
        Options:
        Labels:
        Methods:
  Labels: 
  Data: 
```

**Summary**

* `Type`: Must always be `Resource`.
* `Kind`: Should be `Data`.
* `Name`: Unique identifier for the resource.
* `Metadata`: Contains `Tags` for labeling and categorization.
* `Specifications`:
    * `Name`: Instance name used in development and generation.
    * `Set`: Optional. Used to group resources, similar to projects.
    * `Layers`: Defines layers where only the name is specified.
    * `Labels`: Key-value pairs for filtering and selection.
    * `Data`: Yaml formatted data. Any data compliant with YAML standards can be defined here.



**Fields**

* **Type**: `Resource`
* **Kind**: `Object`
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
* Valid values: Must be `Resource`
* Description: Specifies the type of the model.


**Usage**

The `Type` field identifies the model type as a Resource.



**Notes**

* This field is mandatory and must always be set to `Resource`.


**Example**

```yaml
Type: Resource
```






### `Kind`

**Definition**

* DataType: [`String`][String]
* Type: `fixed-value`
* Multiplicity: Required
* Default: `none`
* Valid values: Must be `Data`
* Description: Specifies the kind of the resource.

**Usage**

The `Kind` field identifies the resource type as an Data.

**Notes**

* This field is mandatory and must always be set to `Data`.

**Example**

```yaml
Kind: Data
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
MetaData:
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
  - Name: catalog
```





### `specifications.layers.name`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: The name of the layer, used as an identifier in Pars and in code generation.

**Usage**

Specifies the `Name` of the layer.

**Notes**

* The `Name` should be compliant with the naming conventions of the target programming language.


**Example**

```yaml
Specifications:
  Layers:
  - Name: catalog
```



### `Specifications.Layers.Sections`

**Definition**

* DataType: `array`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Additional sections for complex structures.


**Usage**

Specifies additional sections for complex resource structures in layer.


**Notes**

* Sections can contain nested classes, attributes, options, labels, and methods.


**Example**

```yaml
Specifications:
  Layers:
    - Name: catalog
      Sections:
      - Name: ValidatorSection
        Classes:
        - Name: Address
          Attributes:
          - Name: street
          - Name: city
          Methods:
          - Name: validate


```








### `Specifications.Labels`

**Definition**

* DataType: `object`
* Type: `map`
* Multiplicity: Optional
* Default: `none`
* Description: Key-value pairs for filtering and selection.

**Usage**

Specifies labels to manage and organize resources based on key-value pairs.

**Notes**

* Labels can be used for filtering and selection in future decision-making processes.

**Example**

```yaml
Specifications:
  Labels:
    environment: production
    module: product
```









### `Specifications.Data`

**Definition**

* DataType: `array` or `object`
* Type: `structured-data`
* Multiplicity: Optional
* Default: `none`
* Description: YAML formatted data. Any data compliant with YAML standards can be defined here.


**Usage**

The `Data` field allows for the definition of data in YAML format. This data can be used to seed databases, initialize configurations, or any other purpose where predefined data is required.



**Example**

```yaml
Specifications:
    Data:
    - id: 1
        Name: Electronics
    - id: 2
        Name: Clothing
    - id: 3
        Name: Home & Kitchen


```









## Examples

???+ example


    ```yaml
    Type: Resource
    Kind: Data
    Name: Product_SeedDataTypes
    MetaData:
    Specifications:
    Name: ProductType
    Set: EShopping
    Layers: 
    - Name:
        Sections:
        - Name:
            Classes:
            Attributes:
            Options:
            Labels:
            Methods:
    Labels: 
    Data:
        - id: 1
        Name: Electronics
        - id: 2
        Name: Clothing
        - id: 3
        Name: Home & Kitchen

    ```

---
This document provides detailed information about the `Data Resource` model used in Pars. The `Data Resource` model is defined with specific fields that help in structuring and managing different data resources. The `Data` field allows for flexible and YAML-compliant data definitions.










<!-- Additional links -->

[String]: ../../../references/value-types.md#string