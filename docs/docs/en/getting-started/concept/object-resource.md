---
title: Object Resource Concept
tags:
    - resource
    - object
---

# Object Resource

An **Object Resource** defines the data structure of a software application. It allows for the definition and management of fields and methods within a table or class, including their data types and relationships.



## Key Features of an Object Resource

- **Data Structure Definition**: Defines the data structure of a software application.
- **Field Management**: Manages fields within a table or class, including their data types.
- **Method Management**: Defines and manages methods within a table or class.
- **Relationships**: Specifies relationships between different fields and methods.
- **YAML Configuration**: Allows for defining and managing object resources through YAML files.
- **Scope**: Can be defined globally or within a specific workspace, determining accessibility.

## Object Resource Object Model

Resources can be defined and managed using YAML configuration files. A typical application project configuration in YAML might look like this:

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

For more detailed information on the Object Resource Object Model, refer to the [Object Resource Object Model][object_resource_object_model].



<!-- Additional links -->

[object_resource_object_model]: ../../guides/schemas/object/resource/object-resource-object-model.md