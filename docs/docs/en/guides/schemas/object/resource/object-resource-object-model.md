---
title: Object Resource Object Model
---

# Object Resource Object Model


## Overview

**YAML Structure**

```yaml
Type: Resource
Kind: Object
Name:  
Metadata:
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
  Attributes: 
    - Name: 
    - Name: 
      Type: 
        Name: 
        Category: resource
      Labels: 
      Category: value|resource|reference
      Common: 
      Generics: 
        - Name: 
          Category: 
          Generics: 
            - Name: 
              Category: 
  Methods: 
    - Name: 
      Options: 
      Labels: 
      Parameters: 
      Returns: 
      Code: 
      Common: false
```

**Summary**

* `Type`: Must always be `Resource`.
* `Kind`: Should be `Object`.
* `Name`: Unique identifier for the resource.
* `Metadata`: Contains `Tags` for labeling and categorization.
* `Specifications`:
    * `Name`: Instance name used in development and generation.
    * `Set`: Optional. Used to group resources, similar to projects.
    * `Layers`: Defines layers where only the name is specified.
    * `Labels`: Key-value pairs for filtering and selection.
    * `Attributes`: Defines the fields of the resource.
    * `Methods`: Function definitions of the resource.



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

* Datatype: [`String`][String]
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

* Datatype: [`String`][String]
* Type: `fixed-value`
* Multiplicity: Required
* Default: `none`
* Valid values: Must be `Object`
* Description: Specifies the kind of the resource.

**Usage**

The `Kind` field identifies the resource type as an Object.

**Notes**

* This field is mandatory and must always be set to `Object`.

**Example**

```yaml
Kind: Object
```






### `Name`

**Definition**

* Datatype: [`String`][String]
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

* Datatype: `object`
* Type: `structured-data`
* Multiplicity: Optional
* Default: `none`
* Description: An object containing metadata about the resource.





### `Metadata.Tags`

**Definition**

* Datatype: `[]string`
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
  tags:
  - backend
  - user
```




### `Specifications`

**Definition**

* Datatype: `object`
* Type: `structured-data`
* Multiplicity: Required
* Default: `none`
* Description: Contains specific details about the resource instance.





### `Specifications.Name`

**Definition**

* Datatype: [`String`][String]
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
  Name: User
```








### `Specifications.Set`

**Definition**

* Datatype: [`String`][String]
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

* Datatype: `array`
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
  layers:
  - Name: Controllers
  - Name: Services
```





### `Specifications.Layers.Name`

**Definition**

* Datatype: [`String`][String]
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
  layers:
  - Name: Controllers
```



### `Specifications.Layers.Sections`

**Definition**

* Datatype: `array`
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
  layers:
    - Name: Validation
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

* Datatype: `object`
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
    module: user
```









### `Specifications.Attributes`

**Definition**

* Datatype: `array`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Defines the fields of the resource, corresponding to properties in a class.

**Usage**

Specifies the attributes of the resource.

**Notes**

* Attributes can be defined inline with just the name or as objects for more advanced configurations.

**Example**

```yaml
Specifications:
  Attributes:
  - Name: firstName
  - Name: age
    Type:
      Name: Int
      Category: value

```









### `Specifications.Attributes.Name`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: The name of the attribute, used as an identifier in Pars and in code generation.

**Usage**

Specifies the `Name` of the attribute.

**Notes**

* The `Name` should be compliant with the naming conventions of the target programming language.


**Example**

```yaml
Specifications:
  Attributes:
  - Name: firstName
```









### `Specifications.Attributes.Type`

**Definition**

* Datatype: [`DataType`](datatype-object-model.md)
* Type: `structured-data`
* Multiplicity: Optional
* Default: `none`
* Description: Specifies the data type of the attribute.

**Usage**

Defines the data type of the attribute.

**Notes**

* Inline for value types or as an object for advanced configurations.

**Example**

```yaml
Specifications:
  Attributes:
  - Name: age
    Type:
      Name: Int
      Category: value

```








### `Specifications.Attributes.Common`

**Definition**

* Datatype: `boolean`
* Type: `boolean`
* Multiplicity: Optional
* Default: `true`
* Description: Indicates whether the attribute is common and generally usable.

**Usage**

Specifies if the attribute is common or specialized.

**Notes**

* Default value is `true`.

**Example**

```yaml
Specifications:
  Attributes:
  - Name: fullName
    Common: false
```









### `Specifications.Methods`

**Definition**

* Datatype: `array`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Defines the methods of the resource.

**Usage**

Specifies the methods of the resource.

**Notes**

* Methods can be defined inline or as objects for more advanced configurations.











### `Specifications.Methods.Name`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: The name of the method.

**Usage**

Specifies the name of the method.

**Notes**

* The `Name` should be compliant with the naming conventions of the target programming language.

**Example**

```yaml
Specifications:
  Methods:
  - Name: calculateAge
```









### `Specifications.Methods.Options`

**Definition**

* Datatype: `object`
* Type: `structured-data`
* Multiplicity: Optional
* Default: `none`
* Description: Additional options for the method.

**Usage**

Specifies additional options for the method.


**Example**

```yaml
Specifications:
  Methods:
  - Name: calculateAge
    Options:
      async: true
```









### `Specifications.Methods.Labels`

**Definition**

* Datatype: `object`
* Type: `map`
* Multiplicity: Optional
* Default: `none`
* Description: Labels for the method.

**Usage**

Specifies labels to manage and organize methods based on key-value pairs.

**Notes**

* Labels can be used for filtering and selection in future decision-making processes.

**Example**

```yaml
Specifications:
  Methods:
  - Name: calculateAge
    Labels:
      utility: true

```









### `Specifications.Methods.Parameters`

**Definition**

* Datatype: `array`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Defines the parameters of the method.

**Usage**

Specifies the parameters of the method.


**Notes**

* Parameters can be defined inline or as objects for more advanced configurations.

**Example**

```yaml
Specifications:
  Methods:
  - Name: calculateAge
    Parameters:
    - Name: birthDate
      Type:
        Name: Date
        Category: value

```













### `Specifications.Methods.Parameters.Name`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: The name of the parameter, used as an identifier in Pars and in code generation.

**Usage**

Specifies the `Name` of the parameter.

**Notes**

* The `Name` should be compliant with the naming conventions of the target programming language.


**Example**

```yaml
Specifications:
  Methods:
    Parameters:
    - Name: firstName
```









### `Specifications.Methods.Parameters.Type`

**Definition**

* Datatype: [`DataType`](datatype-object-model.md)
* Type: `structured-data`
* Multiplicity: Optional
* Default: `none`
* Description: Specifies the data type of the parameter.

**Usage**

Defines the data type of the parameter.

**Notes**

* Inline for value types or as an object for advanced configurations.

**Example**

```yaml
Specifications:
  Methods:
    Parameters:
    - Name: age
      Type:
        Name: Int
        Category: value

```






### `Specifications.Methods.Returns`

**Definition**

* Datatype: `array`
* Type: `list`
* Multiplicity: Optional
* Default: `none`
* Description: Defines the return values of the method.


**Usage**

Specifies the return values of the method.


**Notes**

* Return values can be defined inline or as objects for more advanced configurations.

**Example**

```yaml
Specifications:
  Methods:
  - Name: calculateAge
    Returns:
    - Name: age
      Type:
        Name: Int
        Category: value

```













### `Specifications.Methods.Returns.Name`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Description: The name of the return, used as an identifier in Pars and in code generation.

**Usage**

Specifies the `Name` of the return.

**Notes**

* The `Name` should be compliant with the naming conventions of the target programming language.


**Example**

```yaml
Specifications:
  Methods:
    Returns:
    - Name: firstName
```









### `Specifications.Methods.Returns.Type`

**Definition**

* Datatype: [`DataType`](datatype-object-model.md)
* Type: `structured-data`
* Multiplicity: Optional
* Default: `none`
* Description: Specifies the data type of the return.

**Usage**

Defines the data type of the return.

**Notes**

* Inline for value types or as an object for advanced configurations.

**Example**

```yaml
Specifications:
  Methods:
    Returns:
    - Name: age
      Type:
        Name: Int
        Category: value

```






### `Specifications.Methods.Code`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Optional
* Default: `none`
* Description: The code of the method.

**Usage**

Specifies the body of the method.


**Example**

```yaml
Specifications:
  Methods:
  - Name: calculateAge
    Code: |
      return new Date().getFullYear() - birthDate.getFullYear();

```










### `Specifications.Methods.Common`

**Definition**

* Datatype: `boolean`
* Type: `boolean`
* Multiplicity: Optional
* Default: `true`
* Description: Indicates whether the method is common and generally usable.



**Usage**

Specifies if the method is common or specialized.


**Notes**

* Default value is `true`.


**Example**

```yaml
Specifications:
  Methods:
  - Name: calculateAge
    Common: true

```














## Examples

???+ example


    ```yaml
    Type: Resource
    Kind: Object
    Name: UserResource
    Metadata:
    tags: [user, resource]
    Specifications:
    Name: User
    Set: EShopping
    layers:
    - Name: Controllers
      Sections:
      - Name: AddressSection
          Classes:
          - Name: Address
          Attributes:
          - Name: street
          - Name: city
          Methods:
          - Name: validate
    - Services
    Labels:
        environment: production
        module: user
    Attributes:
    - Name: firstName
        Type:
        Name: String
        Category: value
        Labels:
        Required: true
        Common: true
    - Name: lastName
        Type:
        Name: String
        Category: value
        Labels:
        Required: true
        Common: true
    - Name: age
        Type:
        Name: Int
        Category: value
        Labels:
        Required: true
        Common: true
    - Name: address
        Type:
        Name: AddressResource
        Category: resource
        Labels:
        Required: false
        Common: true
    Methods:
    - Name: getFullName
        Options:
        async: false
        Labels:
        utility: true
        Parameters:
        - Name: title
        Type:
            Name: String
            Category: value
        Returns:
        - Name: fullName
        Type:
            Name: String
            Category: value
        Code: |
        return `${title} ${this.firstName} ${this.lastName}`;
        Common: true

    ```

---
This document provides detailed information about the `Object Resource` model used in Pars. The `Object Resource` model is defined with specific fields and sections that help in structuring and managing different resources.


<!-- Additional links -->

[String]: ../../../references/value-types.md#string