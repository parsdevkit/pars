---
title: Basic Dotnet WebAPI Project
hide:
- navigation
---

# Basic Dotnet WebAPI Project


This guide provides a step-by-step example of creating a basic Dotnet WebAPI project. It includes the necessary configurations for platform, runtime, language, and dependencies.



```yaml
type: Project
kind: Application
name: Example.DotnetWebAPI
metadata:
  tags: [backend, dotnet]
specifications:
  name: DotnetWebAPI
  platform:
    type: Dotnet
    version: 6
  runtime:
    type: Dotnet
    version: 6
  language:
    type: CSharp
    version: 9
  project_type: webapi
  package: com.example.dotnetwebapi
  path: /services/dotnetwebapi
  configuration:
    layers:
    - name: Controllers
      path: controllers
      package: com.example.dotnetwebapi.controllers
    - name: Services
      path: services
      package: com.example.dotnetwebapi.services
    dependencies:
    - name: Microsoft.EntityFrameworkCore
      version: 5.0.0
    - name: Microsoft.AspNetCore.Mvc
      version: 2.2.0

```


## Key Sections Explained

- **type**: The type of the project. Always set to `Project`.
- **kind**: The kind of the project. Should be `Application`.
- **name**: A unique identifier for your project.
- **metadata**: Additional information about your project. Here, tags like `backend` and `dotnet` are used.
- **specifications**: Detailed configuration of your project.
    - **name**: The name of the project instance.
    - **platform**: Specifies the platform type and version. Here, `Dotnet` version 6 is used.
    - **runtime**: Specifies the runtime environment. Here, `Dotnet` version 6 is used.
    - **language**: Specifies the programming language and version. Here, `CSharp` version 9 is used.
    - **project_type**: The type of the project. Here, it is a `webapi`.
    - **package**: The package or namespace for the project.
    - **path**: The relative path where the project will be located.
    - **configuration**: Configuration details for the project.
        - **layers**: Defines the directory and package structure.
        - **dependencies**: Lists the external dependencies, such as NuGet packages.


## Detailed Steps
1. **Set Project Type and Kind**:
      - Ensure `type` is `Project` and `kind` is `Application`.

2. **Provide Unique Name**:
      - Set a unique name for the project under `name` (e.g., `Example.DotnetWebAPI`).

3. **Add Metadata Tags**:
      - Use `metadata` to add tags like `backend` and `dotnet`.

4. **Define Specifications**:
      - **name**: The name of the project instance (e.g., `DotnetWebAPI`).
      - **platform**: Specify the platform type and version (e.g., `Dotnet` version 6).
      - **runtime**: Specify the runtime environment (e.g., `Dotnet` version 6).
      - **language**: Specify the programming language and version (e.g., `CSharp` version 9).
      - **project_type**: Define the type of the project (e.g., `webapi`).
      - **package**: Define the package or namespace for the project (e.g., `com.example.dotnetwebapi`).
      - **path**: Specify the relative path where the project will be located (e.g., `/services/dotnetwebapi`).

5. **Configure Layers**:
      - Define layers for organizing the project's directory and package structure.
      - Example layers:
          - Controllers: Manages HTTP requests.
          - Services: Contains business logic.

6. **Specify Dependencies**:
      - List external dependencies using NuGet packages.
      - Example dependencies:
          - `Microsoft.EntityFrameworkCore` version 5.0.0
          - `Microsoft.AspNetCore.Mvc` version 2.2.0



---
This example shows how to configure a basic Dotnet WebAPI project with the necessary settings for platform, runtime, language, layers, and dependencies. Follow these steps and use the YAML structure provided to create a fully functional Dotnet WebAPI project.

By following this guide, you will have a clear understanding of how to set up a basic Dotnet WebAPI project with the required configurations. This serves as a foundation for more advanced configurations and customizations.
