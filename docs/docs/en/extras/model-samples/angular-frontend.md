---
title: Angular Frontend Project
hide:
- navigation
---

# Angular Frontend Project

This guide provides a step-by-step example of creating a basic Angular frontend project. It includes the necessary configurations for platform, runtime, language, and dependencies.




```yaml
type: Project
kind: Application
name: Example.AngularFrontend
metadata:
  tags: [frontend, angular]
specifications:
  name: AngularFrontend
  platform:
    type: Angular
    version: 12
  runtime:
    type: NodeJS
    version: 14
  language:
    type: TypeScript
    version: 4.3
  project_type: spa
  package: com.example.angularfrontend
  path: /frontend/angularfrontend
  configuration:
    layers:
    - name: Components
      path: components
      package: com.example.angularfrontend.components
    - name: Services
      path: services
      package: com.example.angularfrontend.services
    dependencies:
    - name: @angular/core
      version: 12.0.0
    - name: rxjs
      version: 6.6.0

```


## Key Sections Explained

- **type**: The type of the project. Always set to `Project`.
- **kind**: The kind of the project. Should be `Application`.
- **name**: A unique identifier for your project.
- **metadata**: Additional information about your project. Here, tags like `frontend` and `angular` are used.
- **specifications**: Detailed configuration of your project.
    - **name**: The name of the project instance.
    - **platform**: Specifies the platform type and version. Here, `Angular` version 12 is used.
    - **runtime**: Specifies the runtime environment. Here, `NodeJS` version 14 is used.
    - **language**: Specifies the programming language and version. Here, `TypeScript` version 4.3 is used.
    - **project_type**: The type of the project. Here, it is a `spa` (single-page application).
    - **package**: The package or namespace for the project.
    - **path**: The relative path where the project will be located.
    - **configuration**: Configuration details for the project.
        - **layers**: Defines the directory and package structure.
        - **dependencies**: Lists the external dependencies, such as NPM packages.


## Detailed Steps
1. **Set Project Type and Kind**:
      - Ensure `type` is `Project` and `kind` is `Application`.

2. **Provide Unique Name**:
      - Set a unique name for the project under `name` (e.g., `Example.AngularFrontend`).

3. **Add Metadata Tags**:
      - Use `metadata` to add tags like `frontend` and `angular`.

4. **Define Specifications**:
      - **name**: The name of the project instance (e.g., `AngularFrontend`).
      - **platform**: Specify the platform type and version (e.g., `Angular` version 12).
      - **runtime**: Specify the runtime environment (e.g., `NodeJS` version 14).
      - **language**: Specify the programming language and version (e.g., `TypeScript` version 4.3).
      - **project_type**: Define the type of the project (e.g., `spa`).
      - **package**: Define the package or namespace for the project (e.g., `com.example.angularfrontend`).
      - **path**: Specify the relative path where the project will be located (e.g., `/frontend/angularfrontend`).

5. **Configure Layers**:
      - Define layers for organizing the project's directory and package structure.
      - Example layers:
          - Components: Contains Angular components.
          - Services: Contains services for business logic.

6. **Specify Dependencies**:
      - List external dependencies using NPM packages.
      - Example dependencies:
          - `@angular/core` version 12.0.0
          - `rxjs` version 6.6.0





---
This example shows how to configure a basic Angular frontend project with the necessary settings for platform, runtime, language, layers, and dependencies. Follow these steps and use the YAML structure provided to create a fully functional Angular frontend project.

By following this guide, you will have a clear understanding of how to set up a basic Angular frontend project with the required configurations. This serves as a foundation for more advanced configurations and customizations.
