---
title: Application Project Concept
tags:
    - project
    - application
---

# Application Project

An **Application Project** represents application development projects. It includes additional specifications and management for application development.

## Key Features of an Application Project

- **Workspace Integration**: Positioned within a workspace defined by a group or set.
- **Group Integration**: If defined within a group, it resides under the group's path and package.
- **Development Focus**: Represents the core system of work (e.g., software development projects).
- **YAML Configuration**: Projects are defined and managed through YAML files.
- **Command Support**: Includes commands for submit, list, describe, and remove.
- **Project Types**: Supports various project types based on the project's "Kind".

- **Platform Specification**: Defines the platform on which the application will be developed. Supported platforms are detailed at [Platforms][platforms].
- **Language Specification**: Defines the language used for development. Supported languages are detailed at [Languages][languages].
- **Project Type**: Specifies the type of project, such as web API, web application, mobile, desktop, or SPA.
- **Directory and Package Information**: Specifies the project's directory and package information.
- **Dependency Management**: Manages relationships with other dependent projects.
- **External Package Management**: Manages external packages used by the project.


## Application Project Object Model

Projects can be defined and managed using YAML configuration files. A typical application project configuration in YAML might look like this:

```yaml
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
For more detailed information on the Application Project Object Model, refer to the [Application Project Object Model][application_project_object_model].



<!-- Additional links -->

[application_project_object_model]: ../../guides/schemas/object/project/application-project-object-model.md
[platforms]: ../../extensions/platforms/index.md
[languages]: ../../extensions/languages/index.md