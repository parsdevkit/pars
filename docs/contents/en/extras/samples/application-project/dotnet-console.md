---
title: Dotnet Console Application
hide:
- navigation
---

# Dotnet Console Application


This guide provides a step-by-step example of creating a basic Dotnet console application. It includes the necessary configurations for platform, runtime, language, and dependencies.



```yaml
type: Project
kind: Application
name: Example.DotnetConsoleApp
metadata:
  tags: [console, dotnet]
specifications:
  name: DotnetConsoleApp
  platform:
    type: Dotnet
    version: 6
  runtime:
    type: Dotnet
    version: 6
  language:
    type: CSharp
    version: 9
  project_type: console
  package: com.example.dotnetconsoleapp
  path: /apps/dotnetconsoleapp
  configuration:
    layers:
    - name: Program
      path: program
      package: com.example.dotnetconsoleapp.program
    dependencies:
    - name: Newtonsoft.Json
      version: 13.0.1


```


## Key Sections Explained

- **type**: The type of the project. Always set to `Project`.
- **kind**: The kind of the project. Should be `Application`.
- **name**: A unique identifier for your project.
- **metadata**: Additional information about your project. Here, tags like `console` and `dotnet` are used.
- **specifications**: Detailed configuration of your project.
    - **name**: The name of the project instance.
    - **platform**: Specifies the platform type and version. Here, `Dotnet` version 6 is used.
    - **runtime**: Specifies the runtime environment. Here, `Dotnet` version 6 is used.
    - **language**: Specifies the programming language and version. Here, `CSharp` version 9 is used.
    - **project_type**: The type of the project. Here, it is a `console`.
    - **package**: The package or namespace for the project.
    - **path**: The relative path where the project will be located.
    - **configuration**: Configuration details for the project.
        - **layers**: Defines the directory and package structure.
        - **dependencies**: Lists the external dependencies, such as NuGet packages.



## Detailed Steps
1. **Set Project Type and Kind**:
      - Ensure `type` is `Project` and `kind` is `Application`.

2. **Provide Unique Name**:
      - Set a unique name for the project under `name` (e.g., `Example.DotnetConsoleApp`).

3. **Add Metadata Tags**:
      - Use `metadata` to add tags like `console` and `dotnet`.

4. **Define Specifications**:
      - **name**: The name of the project instance (e.g., `DotnetConsoleApp`).
      - **platform**: Specify the platform type and version (e.g., `Dotnet` version 6).
      - **runtime**: Specify the runtime environment (e.g., `Dotnet` version 6).
      - **language**: Specify the programming language and version (e.g., `CSharp` version 9).
      - **project_type**: Define the type of the project (e.g., `console`).
      - **package**: Define the package or namespace for the project (e.g., `com.example.dotnetconsoleapp`).
      - **path**: Specify the relative path where the project will be located (e.g., `/apps/dotnetconsoleapp`).

5. **Configure Layers**:
      - Define layers for organizing the project's directory and package structure.
      - Example layer:
          - Program: Contains the main program logic.

6. **Specify Dependencies**:
      - List external dependencies using NuGet packages.
      - Example dependency:
          - `Newtonsoft.Json` version 13.0.1




---
This example shows how to configure a basic Dotnet console application with the necessary settings for platform, runtime, language, layers, and dependencies. Follow these steps and use the YAML structure provided to create a fully functional Dotnet console application.

By following this guide, you will have a clear understanding of how to set up a basic Dotnet console application with the required configurations. This serves as a foundation for more advanced configurations and customizations.
