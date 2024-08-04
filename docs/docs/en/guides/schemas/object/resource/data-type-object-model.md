---
title: DataType Object Model
---

# Data Type Object Model


## Overview

The `DataType` object defines the data type for attributes, method parameters, and return values within a resource. This documentation provides a detailed explanation of the fields and usage of the `DataType` object.

**YAML Structure**

```yaml
Type:
  Name: 
  Category: value|resource|reference
  Generics:
    - Name: 
      Category: 
      Generics:
        - Name: 
          Category: 

```

**Summary**

* `Name`: The name of the data type.
* `Category`: The category of the data type. Can be `value`, `resource`, or `reference`.
* `Generics`: Specifies the generic parameters for the data type.




**Fields**

* **Name**: [`String`][String]
* **Category**: `Enum`
* **Generics**: [`[]DataType`](#data-type-object-model)


**Required Fields**

* `Name`


## Field Descriptions

### `Name`

**Definition**

* DataType: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: The name of the data type. Can be a value type, another resource, or a reference type.


**Usage**

Specifies the name of the data type.



**Notes**

* Value types are built-in types such as `Int`, `String`, etc. You can see all [Value Types](../../../references/value-types.md)
* Resource types refer to existing resources in Pars.
* Reference types refer to types defined in external packages or frameworks.

**Example**

```yaml
Type:
  Name: String
```






### `Category`

**Definition**

* DataType: `Enum`
* Type: `enum`
* Multiplicity: Required
* Default: `none`
* Valid values: `value`, `resource`, `reference`
* Description: Specifies the category of the data type.


**Usage**

Defines the category of the data type.



**Notes**

* `value`: Built-in types like `Int`, `String`.
* `resource`: Existing resources in Pars.
* `reference`: External types from frameworks or packages.

**Example**

```yaml
Type:
  Category: value
```






### `Generics`

**Definition**

* DataType: [`[]DataType`](#data-type-object-model)
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Specifies the generic parameters for the data type.

**Usage**

Defines the generic parameters for the data type

**Notes**

* Used for complex types that require generic parameters.


**Example**

```yaml
Type:
  Name: List
  Generics:
  - Name: String
    Category: value

```







## Examples

???+ example


    ```yaml
    Type:
      Name: Dictionary
      Category: reference
      Generics:
      - Name: String
        Category: value
      - Name: Int
        Category: value


    ```

---
This document provides detailed information about the `DataType` object used in Pars. The `DataType` object is defined with specific fields that help in structuring and managing different value types within resources, method parameters, and return values.








<!-- Additional links -->

[String]: ../../../references/value-types.md#string