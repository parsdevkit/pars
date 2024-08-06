---
title: Data Resource Concept
tags:
    - resource
    - object
---

# Data Resource

A **Data Resource** allows for the dynamic definition of data. It enables flexible data specification in YAML format.


## Key Features of an Data Resource

- **Dynamic Data Definition**: Allows for the flexible definition of data.
- **YAML Configuration**: Enables data specification and management through YAML files.
- **Key-Value Pairs**: Supports defining data as key-value pairs.
- **Scope**: Can be defined globally or within a specific workspace, determining accessibility.


## Data Resource Object Model

Resources can be defined and managed using YAML configuration files. A typical application project configuration in YAML might look like this:

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
For more detailed information on the Data Resource Object Model, refer to the [Data Resource Object Model][data_resource_object_model].



<!-- Additional links -->

[data_resource_object_model]: ../../guides/schemas/object/resource/data-resource-object-model.md