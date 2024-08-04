---
title: Group Object Model
---

# Group Object Model

## Overview

**YAML Structure**

```yaml
Type: Group
Name:  
Metadata:
  Tags: 
Specifications:
  Name: 
  Path: 
  Package: 
```

**Summary**

* `Type`: Must always be `Group`.
* `Name`: Unique identifier for the group, applicable across different workspaces.
* `Metadata`: Contains `tags` for labeling and categorization. See the Metadata Section Documentation.
* `Specifications`:
    * `Name`: Instance name used in development and generation.
    * `Path`: Relative path in the workspace; defaults to `Name` if not specified.
    * `Package`: Defines the package or namespace; can be a string array or a `/` separated string; defaults to name if not specified. See the Specifications Section Documentation.

This document serves as a guide for developers to correctly define and use the `Group` model in their YAML manifest files, ensuring proper structure and consistency in the workspace.


**Fields**

* **Type**: `Group`
* **Name**: [`String`][String]
* **Metadata**: [`Metadata`](#metadata)
* **Specifications**: [`Specifications`](#specifications)

**Required Fields**

* `Type`
* `Name`
* `Specifications.Name`


## Field Descriptions

### `Type`

**Definition**

* Datatype: [`String`][String]
* Type: `fixed-value`
* Multiplicity: Required
* Default: `none`
* Valid values: Must be `Group`
* Description: Specifies the type of the model.

**Usage**

The `Type` field identifies the model type as a Group.

**Notes**

* This field is mandatory and must always be set to `Group` and cannot be changed


**Examples**

```yaml
Type: Group
```


### `Name`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Required
* Default: `none`
* Valid values: Any string value that ensures uniqueness within the environment
* A unique identifier for the group, assigned by the developer. This name should be unique within the selected environment, as the group is independent of the workspace and can be used across different workspaces.

**Usage**

The `Name` is used to identify the group model and must align with the project architecture and plan.

**Notes**

* Ensure the `Name` is unique to avoid conflicts across different workspaces.


**Examples**

```yaml
Name: UserManagementGroup
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
  - user-management
```

```yaml
Metadata:
  Tags: [backend, user-management]
```

### `Specifications`

**Definition**

* Datatype: `object`
* Type: `structured-data`
* Multiplicity: Required
* Default: `none`
* Description: Contains specific details about the group instance.


### `Specifications.Name`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Optional
* Default: `none`
* Description: The name given to the group instance. This is used during development or generation processes. While the `Name` in the header identifies the model, the `Name` in the specifications identifies the instance of the group.


**Usage**

This `Name` is used to reference the specific instance of the group.


**Notes**

* Different from the header `Name`, which identifies the model.


**Examples**

```yaml
Specifications:
  Name: UserManagement
```


### `Specifications.Path`

**Definition**

* Datatype: [`String`][String]
* Type: `text`
* Multiplicity: Optional
* Default: Uses `Name` if not provided
* Description: The relative path of the group within the workspace. When the group is physically constructed, it will be created at the path defined here.
* Valid values: Any valid relative path.



**Usage**

Define a specific `Path` to control where the group is created in the workspace.


**Notes**

* If no `Path` is defined, the group name is used as the default path.




**Examples**

```yaml
Specifications:
  Path: src/user_management
```


### `Specifications.Package`

**Definition**

* Datatype: [`String`][String] or [`[]String`][String]
* Type: `text` or `list`
* Multiplicity: Optional
* Default: Uses `Name` if not provided
* Description: Labels for the group, used for filtering, grouping, and selection purposes.
* Valid Values: Any string or array of strings. If a single string is provided, it can be separated by `/`.

**Usage**

Specify the `Package` to organize code and resources under a specific namespace.


**Notes**

* If no `Package` is defined, the group `Name` is used as the default package name.



**Examples**

```yaml
Specifications:
  Package: com.example.user
```

```yaml
Specifications:
  Package: com/example/user
```


```yaml
Specifications:
  Package: [com, example, user]
```

```yaml
Specifications:
  Package: 
  - com
  - example
  - user
```




## Examples

???+ example


    ```yaml
    Type: Group
    Name: UserManagementGroup
    Metadata:
      Tags: [backend, user-management]
    Specifications:
      Name: UserManagement
      Path: src/user_management
      Package: [com, example, user]
    ```

---
This document provides detailed information about the `Group` model used in Pars for dynamic code generation. The Group model is defined with specific fields and sections that help in structuring and managing different groups. Model and references to detailed documentation for each section: `Metadata`, and `Specifications`.



<!-- Additional links -->
[String]: ../../../references/value-types.md#string